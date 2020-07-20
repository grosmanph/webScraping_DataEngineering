import os

def check_webdriver(path):
    """
        This function verifies if there's a file named 'chromedriver.exe'
        in the directory passed as 'path'. It's important to define the variable
        'path' and the name of the web driver properly.
        
        Parameters:
        path (str): The folder path where the Chrome Web Driver is located.
        
        Returns:
        int: It returns 1 ('Chrome Web Driver location is OK') if
        the file has been found or 0 ('Chrome Web Driver not found') if the
        file hasn't been found.
    """
    try:
        curr_dir = os.path.abspath(os.getcwd())
        os.chdir(path)
        if os.path.exists('chromedriver.exe'):
            print('Chrome Web Driver location is OK')
            os.chdir(curr_dir)
            return 1
        else:
            print('Chrome Web Driver not found')
            os.chdir(curr_dir)
            return 0
    
    except:
        print('Something is wrong with this path\n')
        return 0
    
