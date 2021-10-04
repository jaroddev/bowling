include "globals.mzn";

set of 1..10: quille;

array[1..20] of quille: score;

% nooverlap
% predicate no_overlap(var int:s1, int:d1, var int:s2, int:d2) =
%    s1 + d1 <= s2 \/ s2 + d2 <= s1;

predicate norm(array[1..20] of quille: score) = 
   forall(i in quille, j in quille) ( let {
     
   
   });
   
% /\ (score[i] + score[j] <= 10) /\ ()    
   
constraint norm(score);

solve satisfy;