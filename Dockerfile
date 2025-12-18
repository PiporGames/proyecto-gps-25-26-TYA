FROM ubuntu:latest

RUN apt-get update && apt upgrade -y && apt install lsb-release wget git tree -y && apt autoremove -y
RUN wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt update && apt install dotnet-sdk-8.0 -y && apt autoremove -y
COPY . /tya
WORKDIR /tya
RUN dotnet publish -c Release -o build
CMD ["dotnet", "build/tya.dll"]