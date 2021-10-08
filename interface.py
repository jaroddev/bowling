from tkinter import *
from index import solveInstance


def action():
    # récupérer les données de l'entrée2 
    cible = int (entrée2.get())
    
    # solve the problem
    result = solveInstance(cible)
    print(result)

    # mettre un text par défaut pour l'entrée
    entrée1.insert(0,result)


# Création d'une fenêtre avec la classe Tk :
fenetre = Tk()
# Ajout d'un titre à la fenêtre principale :
fenetre.title("My bowling")
# Définir un icone :
fenetre.iconbitmap("")
# Définir les dimensions par défaut la fenêtre principale :
fenetre.geometry("400x300")
label1 = Label (fenetre, text = "Lancers")
label1.place(x=50,y=50)

entrée1 = Entry (fenetre)
entrée1.place(x=200,y=50)

label2 = Label (fenetre, text = "Score")
label2.place(x=50,y=100)

entrée2 = Entry (fenetre)
entrée2.place(x=200,y=100)

Calculer=Button(fenetre, text="Calculer", command = action)
Calculer.place(x=200,y=150)
# Affichage de la fenêtre créée :
fenetre.mainloop()