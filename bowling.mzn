include "globals.mzn";

set of int:quilles=0..10;
set of int:lancers=1..21;
set of int:tours=1..10;
set of int:points=0..30;

array[lancers] of var quilles:init;%=[10,0,10,0,10,0,10,_,_,_,_,_,_,_,_,_,_,_,_,_,_];

array[lancers] of var quilles:partie;
array[tours] of var points:score;
array[tours] of var points:bonus;
var int:score_total;
var int:nb_spares;
var int:nb_strikes;
var int:nb_fails; %nombre de lancer = 0 (pas après un strike)


int: cible;

constraint nb_strikes >= 0;
constraint nb_spares >= 0;
constraint nb_fails >= 0;

%init
constraint forall(l in lancers)(partie[l]=init[l]);

%contraintes de liaisons
constraint (score_total=sum(t in tours)(score[t])+sum(t in tours)(bonus[t])); % score sum + bonus sum
constraint forall( t in tours where t<10)(score[t]=partie[2*t-1]+partie[2*t]); %score simple de base sauf dernier coup
constraint score[10]=partie[19]+partie[20]+partie[21]; % score simple dernier coups

%les bonus
constraint forall(t in tours)((partie[2*t-1]+partie[2*t]<10)->(bonus[t]=0)); %pas de bonus 
constraint forall(t in tours)(((partie[2*t-1]+partie[2*t]=10)/\(partie[2*t-1]!=10))->(bonus[t]=partie[2*t+1])); %spare

constraint forall(t in tours where t<9)((partie[2*t-1]=10)/\(partie[2*t+1]!=10) -> bonus[t]=partie[2*t+1] + partie[2*t+2] );  % single strike
constraint forall(t in tours where t<9)((partie[2*t-1]=10)/\(partie[2*t+1]=10) -> bonus[t]=partie[2*t+1] + partie[2*t+3] );  % multi strike
constraint ((partie[17]=10) -> bonus[9]=partie[19]+partie[20]); %bonus strike final-1

constraint ((partie[19]=10) -> bonus[10]=partie[20]+partie[21]); %bonus strike final

%contraintes de jeu
constraint forall(t in tours where t<10)(partie[2*t-1]+partie[2*t]<=10); % val1+ val2 <= 10
constraint ((partie[21]!=0)-> (partie[19]+partie[20]>=10)); %final spare
constraint ((partie[19]!=10)->(partie[19]+partie[20]<=10)); %no final strike

%nombre de spares et de strikes et coups nuls
constraint nb_strikes=sum(t in tours)(bool2int(partie[2*t-1]=10))+bool2int(partie[21]=10);
constraint nb_spares=sum(t in tours)(bool2int(partie[2*t-1] + partie[t*2] = 10 /\ partie[2*t-1]!= 10));
constraint nb_fails=sum(t in tours where t<10)(
  bool2int(partie[2*t-1]=0) + bool2int(partie[2*t-1]!=10/\partie[2*t]=0)
)+bool2int(partie[19]=0) + bool2int(partie[19]!=10 /\ partie[20]=0) + bool2int(partie[19]=10 /\ partie[21]=0);


%score souhaité
constraint (score_total=cible);

%resolution

% solve::int_search(partie, dom_w_deg, indomain_max,complete) maximize(nb_strikes);

% solve::int_search(partie, dom_w_deg, indomain_max,complete) maximize(nb_fails);

% solve::int_search(partie, dom_w_deg, indomain_max,complete) minimize(abs(nb_spares-nb_strikes));

% solve::int_search(partie, dom_w_deg, indomain_max,complete) maximize(nb_spares);

solve::int_search(partie, first_fail, indomain_max,complete) satisfy;

% solve satisfy; 

output[""]++[if ((l mod 2==0) /\ (fix(partie[l-1])=10)/\(l!=20)) then "X" else show(partie[l]) endif ++ if (l mod 2==0) then "|" else " " endif|l in 1..20]++[if ((fix(partie[21])=0) /\ (fix(partie[19])!=10)) then " " else show(partie[21]) endif];          
% output["Lancers : "]++[if ((l mod 2==0) /\ (fix(partie[l-1])=10)/\(l!=20)) then "X" else show(partie[l]) endif ++ if (l mod 2==0) then "|" else " " endif|l in 1..20]++[if ((fix(partie[21])=0) /\ (fix(partie[19])!=10)) then " " else show(partie[21]) endif]++["\nScores base : "]++[show(score[t])++" "|t in tours]++["\nBonus : "]++[show(bonus[t])++" "|t in tours]++["\nScore Total : "]++[show(score_total)]++["\nSpares : "]++[show(nb_spares)]++["\nStrikes : "]++[show(nb_strikes)]++["\nFails : "]++[show(nb_fails)];