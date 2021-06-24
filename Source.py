'''
1) Take any password and account for which it will be valid
2) Tell whether it is good, bad or strong
3) Package it using a custom encryption Algorithm
4) Provide a key to the user
5) Decrypt a file using a key
6) Feature to store it in cloud-- Dropbox or google Drive

This is AES 128, 16 bit key
'''
import getpass
import random
import string
import sys
import os
import time
from time import sleep
from progress.bar import Bar

import getpass
import re

from Crypto.PublicKey import RSA
from Crypto.Random import get_random_bytes
from Crypto.Cipher import AES, PKCS1_OAEP


class Encrypto:

    version = "1.01"
    username = ""
    password = ""
    fileName = "PASS.txt"
    Key = ""

    # initialising innput for username and password, storing them in a temporary text file . In case of no encryption the text file will persist in the user's system
    def __init__(self):
        print("################################### WELCOME TO THE ENCRYPTOR BY AINC########################################\n\n\t\t\t\t\tThis is your own mobile vault")

        self.username = input(
            "\nPlease enter the username you wish to add for encryption: \n")
        self.password = getpass.getpass(
            "\nPlease enter the password to evaluate: \n")
        print("We shall now be storing your password securely in a file...initialising setup please wait..")

        f = open(self.fileName, "w+")

        # Progress bar to add a little bling
        bar = Bar('Adding to file', max=3)
        f.write('############################################### Welcome to The VAULT ##########################################')
        f.write('\n\n##########UserName##########\n' + self.username)
        f.write('\n\n##########Password##########\n' + self.password)
        for i in range(3):
            # Do some work
            sleep(1)
            bar.next()
        bar.finish()
        f.close()

    # Generate RSA KEY to allow encryption

    def RSA_gen(self):
        print("\n\n**************************************Initialising Encryption*****************************************************\nBefore beginning you might want to check out the following points\n1) Encryption is a highly detailed and memory intensive process , be sure to have minimum hardware requirements before running the Encryptor.\n2) We at AINC are not responsible for any loss of data in case of loss of The Key of your encypted file.\n3) Make sure to never send The Key over internet or any media.\n")
        choice = input("Do you want to continue? (y/n):\n")

        if choice == 'y' or choice == 'Y' or choice == 'Yes' or choice == 'yes' or choice == 'YES':
            bar = Bar('Generating Secure Key', max=2)
            for i in range(2):
                # Do some work
                sleep(1)
                bar.next()

            # Generating the passphrase for key pair generation
            Key = ''.join(random.choice(string.ascii_uppercase +
                          string.digits) for _ in range(6))
            self.Key = Key

            print("\n\nThis shall be your key that you may use for decrypting your file, keep it safe and NEVER share it with any unauthorized person/software. \n" + Key)
            bar.finish()

            R_enc_key = RSA.generate(2048)
            encrypted_key = R_enc_key.exportKey(
                passphrase=self.Key, pkcs=8, protection="scryptAndAES128-CBC")
            with open('my_private_rsa_key.bin', 'wb') as f:
                f.write(encrypted_key)
            with open('my_rsa_public_key.pem', 'wb') as f:
                f.write(R_enc_key.publickey().exportKey())
        else:
            print("\nNo Problem! Let's do this again someday!")

    # A basic password evaluator to check the password strength

    def Evaluator(self):

        passw = self.password

        if len(passw) <= 6:
            print('The password must be between 6 and 12 characters.\n')
            return 1

        else:
            password_scores = {0: 'Horrible',
                               1: 'Weak', 2: 'Medium', 3: 'Strong'}

            password_strength = dict.fromkeys(
                ['has_upper', 'has_lower', 'has_num'], False)
            if re.search(r'[A-Z]', passw):
                password_strength['has_upper'] = True
            if re.search(r'[a-z]', passw):
                password_strength['has_lower'] = True
            if re.search(r'[0-9]', passw):
                password_strength['has_num'] = True

            score = len([b for b in password_strength.values() if b])

            if (password_scores[score] == "Weak"):
                print(
                    "\nYour password score is: Weak!\nHere's what you should try-\n1) Ensure that your password contains atleast one capital letter.\n2) Use numbers 0-9 in your password to make it stronger! \n3) Use symbols where possible to make it even more credible\n")

            elif (password_scores[score] == "Medium"):
                print(
                    "\nYour password score is: Good Enough!\nYou already have a decent password score, try the following to get even better rating!-\n1) Ensure that your password contains atleast one capital letter.\n2) Use numbers 0-9 in your password to make it stronger! \n3) Use symbols where possible to make it even more credible\n")

            else:
                print(
                    "\nYour password score is: Awesome!\nThis password activates god mode! Congrats you are protected!\nDon't forget to change your password regularly to prevent any hacks!\n")

    # Encryption using AES OAEP
    def encrypt(self):
        # the chunksize is basically the amount of data being read at a time
        chunksize = 64*1024
        pub_key = input(
            "Enter the path to your public key:(e.g /home/pub_key.pem)\n")
        with open('PASS.txt', 'rb') as infile:
            with open('AINC_encrypted_File.bin', 'wb') as outfile:
                recipient_key = RSA.import_key(
                    open(pub_key).read())
                # IN OAEP we have to generate a random string to fill in the encryption, we have used a 16 byte string here
                session_key = get_random_bytes(16)

                # Cipher will be used to encrypt the data using the public key.
                cipher_rsa = PKCS1_OAEP.new(recipient_key)
                outfile.write(cipher_rsa.encrypt(session_key))

                cipher_aes = AES.new(session_key, AES.MODE_EAX)

                # reading the text file as a chunk of bytes at a time and allowing encryption for the same
                while True:
                    chunk = infile.read(chunksize)
                    if len(chunk) == 0:
                        break
                    elif len(chunk) % 16 != 0:
                        chunk += b' ' * (16 - len(chunk) % 16)

                    ciphertext, tag = cipher_aes.encrypt_and_digest(chunk)

                    outfile.write(cipher_aes.nonce)
                    outfile.write(tag)
                    outfile.write(ciphertext)

                    os.remove("PASS.txt")
                    bar = Bar('Encrypting File', max=2)
                    for i in range(2):
                        # Do some work
                        sleep(1)
                        bar.next()
                    bar.finish()
                    print("Successfully completed encrypting the file!")

    # Decrypting the data

    def decrypt(self):

        Key = input("Enter your secret Key:\n")
        with open('AINC_encrypted_File.bin', 'rb') as fobj:
            with open('decrypted.txt', 'wb') as outfile:
                private_key = RSA.import_key(
                    open('my_private_rsa_key.bin').read(), passphrase=Key)
                enc_session_key, nonce, tag, ciphertext = [fobj.read(x)
                                                           for x in (private_key.size_in_bytes(),
                                                                     16, 16, -1)]

                cipher_rsa = PKCS1_OAEP.new(private_key)
                session_key = cipher_rsa.decrypt(enc_session_key)
                cipher_aes = AES.new(session_key, AES.MODE_EAX, nonce)

                data = cipher_aes.decrypt_and_verify(ciphertext, tag)

                # check whether dencryption is done properly or not
                # print(data)
                outfile.write(data)

                bar = Bar('Decrypting File', max=2)
                for i in range(2):
                    # Do some work
                    sleep(1)
                    bar.next()
                bar.finish()
                print("Successfully completed Decrypting the file!")


if __name__ == "__main__":
    e = Encrypto()
    # e.Evaluator()
    print("\nGreat Job! Now that we have our setup successfully initialised, what would you like to do?")
    while True:
        choice = input(
            "\n1) Get the current password appraised.\n2) Encrypt your current Username and Password File.\n3) Decrypt an existing file (Secret key needed)\n4) Generate a new RSA key pair. \n5) Quit for now.\n(Enter your choices as 1-5)\n")

        if(choice == "1"):
            e.Evaluator()
        elif(choice == "2"):
            e.encrypt()
        elif(choice == "3"):
            e.decrypt()
        elif(choice == "4"):
            e.RSA_gen()
        elif(choice == "5"):
            print("\nThank you for using the Encryptor by AINC! Hope to see you soon!")
            exit(1)
        else:
            print("Wrong input, please enter again!")
