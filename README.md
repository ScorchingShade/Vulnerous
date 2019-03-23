# Vulnerous v2.0

Vulnerous is a linux script that aggregates several network security and analysis features into an easy to understand package. **Vulnerous** provides a simplified **commandline** interface which is best suited for beginners and security enthusiasts trying to dive into cybersecurity.

### What's New in version 2.0?
> The Encryptor© by Ankush Sharma support provided. 
> Now encrypt your passwords by state of the art AES 128 bit Encryption. A protected file available for easy sharing on web makes your life easy as a security admin of your team!

## Suites

Vulnerous is still in development and consists of the following suites :-

- **IP Finder Suite** - The IP Finder helps you to find both your public and private IP's with a quick command.
- **Reconnaissance Suite** - The reconnaissance suite integrates several features from N-Map to intelligently find and document your results. Reports are generated to document analysed networks.
- **The Encryptor©** - The Encryptor allows for a wider cryptographic access within Vulnerous. Read more about the encryptor at [Encryptor©](https://github.com/ScorchingShade/Encryptor)

## Understanding Vulnerous
![alt text](https://github.com/ScorchingShade/Vulnerous/blob/master/uml_vulnerous.png)

## Getting Started
> The best thing about vulnerous is its simplicity and ease of use. You don't have to understand a lot of tools and networking to generate reports! This is a true chill dream!!

The Vulnerous source code is written in Bash script. It easy enough to understand and contributions to the script are always welcome.

A snippet of the script is shown below:
```bash
PRIV_IP_ADDR=`hostname -I | awk '{print $1}'`
```
### Prerequisites
- **N-Map** --> Easily download N-map using the official Link. [N-Map](https://nmap.org/download.html)<br />
or using the commandline utility on debian systems
```terminal
sudo apt-get install N-MAP
```
- **Command Line Calculator** --> Download the 'bc' calculator using following commands.
```terminal
sudo apt-get install bc
```
- **Linux OS** - Debian based distro is preferred.

### Using Vulnerous
- To start Vulnerous, clone the repository and install any prerequisite package.
- Make the script executable by typing following as root in terminal :
```terminal
chmod u+x killer.sh
```
- Execute the script using the following command :
```terminal
./killer.sh
```
## Contributing
Vulnerous is still in development and to contribute to this awesome software please contact the author.
## Author
### [Ankush Sharma](https://scorchingshade.github.io/) 
- [LinkedIn](https://linkedin.com/in/ankush-sharma-a9b24a37/)
- [Facebook](https://www.facebook.com/kushuas)
- [Medium](https://medium.com/@ankushsharma_70830)
- **Mail** - ankushors789@gmail.com

I code, I write, I hack, I preach. <br />
Always available for any opportunities! (Pssst...I am really passionate about cybersecurity).

## License
```
Copyright (C) 2019 Ankush Sharma @ AINC

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
```
## Acknowledgments
- Shout out to Offensive Security for their awesome blogs and documentation.
- Respect for nachoparker for his amazing tutorial on creating a cool progress bar

