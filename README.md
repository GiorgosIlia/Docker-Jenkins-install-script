# Docker and Jenkins Installation Script

This script automates the installation of Docker and Jenkins on a Linux system. It removes existing Docker-related packages, installs Docker, runs a test container, and installs Jenkins.

## Usage

**Note: This script is designed for Ubuntu-based systems.**

1. Clone the repository:

    ```bash
    git clone https://github.com/your-username/your-repo.git
    cd your-repo
    ```

2. Make the script executable:

    ```bash
    chmod +x install.sh
    ```

3. Run the script:

    ```bash
    ./install.sh
    ```

## Prerequisites

Before running the script, ensure you have the following prerequisites:

- A Linux system (Ubuntu-based)
- Internet connection for package downloads

## Script Details

- The script first removes existing Docker-related packages.
- It updates the package index and installs required packages for enabling HTTPS repositories.
- Docker's official GPG key is added to the keyring, and the Docker repository is added.
- Docker is then installed, and a test container is run to verify the installation.
- The Docker service is restarted, and the current user is added to the Docker group to run Docker without sudo.
- Java (OpenJDK 8) is installed, which is required for Jenkins.
- Jenkins repository key is added, and the Jenkins repository is added.
- Jenkins is installed, and its status is checked.

## Contributing

If you encounter issues or have suggestions for improvement, feel free to open an [issue](https://github.com/GiorgosIlia/Docker-Jenkins-install-script-/issues) or submit a pull request.

## License

This script is licensed under the [License Name] - see the [LICENSE](LICENSE) file for details.
