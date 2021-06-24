# Vulnerous v3.0

Vulnerous is a linux script that aggregates several network security and analysis features into an easy to understand package. **Vulnerous** provides a simplified **commandline** interface which is best suited for beginners and security enthusiasts trying to dive into cybersecurity.

### What's New in version 3.0?
> Vulnerous-web© by Ankush Sharma support provided. 
> Make comprehensive Vulnerability reports of any website by Vulnerous-web! Over 80 different checks and 20 different tools available!
> HUGE UI CHANGE! Vulnerous now comprises of terminal colors. Better interactive experience and more modules support.
> Bug fixes.

### Upcoming
> Wider Encryption support to be added soon for the Encryptor! 
> Support for windows coming soon!! A Java based Aes-256 encryption locker to be available soon!


## Suites

Vulnerous is still in development and consists of the following suites :-

- **IP Finder Suite** - The IP Finder helps you to find both your public and private IP's with a quick command.
- **Reconnaissance Suite** - The reconnaissance suite integrates several features from N-Map to intelligently find and document your results. Reports are generated to document analysed networks.
- **The Encryptor©** - The Encryptor allows for a wider cryptographic access within Vulnerous. Read more about the encryptor at [Encryptor©](https://github.com/ScorchingShade/Encryptor)
- **Vulnerous-web©** - Vulnerous-web allows for comprehensive Vulnerability analysis for any url/website/webapp. Read more about Vulnerous-web at [Vulnerous-web©](https://github.com/ScorchingShade/Vulnerous-web)

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
- **Command Line Calculator** --> Download the 'bc' calculator using following command.
```terminal
sudo apt-get install bc
```
- **Command Line Ip Calculator** --> Download 'ipcalc' calculator using the following command.
    - Calculates IP broadcast, network, Cisco wildcard mask, and host ranges
```terminal
sudo apt-get install ipcalc
```
- **Command Line utility to download files from the web** --> Download 'wget' using the following command.

```terminal
sudo apt-get install wget
```

- **Linux OS** - Kali linux is preferred.
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
it under the terms of the MIT License as it is published.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
MIT License for more details.

You should have received a copy of the Mit License
along with this program.  
```
## Acknowledgments
- Shout out to Offensive Security for their awesome blogs and documentation.
- Respect for nachoparker for his amazing tutorial on creating a cool progress bar

