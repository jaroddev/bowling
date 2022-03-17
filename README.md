# bowling project

Bowling comes with a more complex scoring system than we think, in this repository we use
a CSP solver like minizinc and the python Tkinter UI toolkit library to create an application that returns
a move combination for a given score.


# Create the python virtual environment

Create the environment
```
python3 -m venv bowling-env
```

Activate the python virtual environment
```
source bowling-env/bin/activate
```

Update pip
```
pip install -U pip
```

Install every required dependencies recursively
```
pip install -r requirements.txt
```

# Ensure that you can run tkinter
```
python3 -m tkinter
```

If you are on debian and you can't run the module tkinter run the following command
```
sudo apt install python3-tk
```

# run the application 
```
python3 interface.py
```
