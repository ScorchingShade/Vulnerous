# Vulnerous

Vulnerous is a linux script that aggregates several network security and analysis features into an easy to understand package. **Vulnerous** provides a simplified **commandline** interface which is best suited for beginners and security enthusiasts trying to dive into cybersecurity.


## Suites

Vulnerous is still in development and consists of the following suites :-

- **IP Finder Suite** - The IP Finder helps you to find both your public and private IP's with a quick command.
- **Reconnaissance Suite** - The reconnaissance suite integrates several features from N-Map to intelligently find and document your results. Reports are generated to document analysed networks.

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
- **N-Map** --> Easily download N-map using the official Link. [N-Map](https://nmap.org/download.html)
or using the commandline utility on debian 
```terminal
sudo apt-get install bc
```
- **Command Line Calculator** --> Download the 'bc' calculator using following commands.

### Using Vulnerous
- To start Vulnerous, clone the repository 
