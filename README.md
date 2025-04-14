# Dotfiles

This repository contains configuration files (dotfiles) for commonly used programs. These files help streamline setup and ensure consistency across environments.





Current support for the following OSs:

1. Windows  (*configuration under maintenance*)
3. MacOS   (*configuration under maintenance*)
4. Linux:
    - Ubuntu/Debian  (***currently working***)
    - Arch linux
    - Fedora

## Features

1. LazyVim for Neovim, with pre-setup configuration:
    ![LazyVim](https://github.com/user-attachments/assets/7e2687c8-8aab-450e-b9fc-e696e036f269)

- Pre-configured settings for frequently used tools.
- Easy-to-use and customizable setup.
- Designed for productivity and efficiency.
  
*working setup for Github Copilot integration*

2. Starship
   - ![powershell example](https://github.com/user-attachments/assets/a3e57969-9399-4615-98b7-4ed991b2c8da)   

## Usage

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/dotfiles.git
    ```
2. Navigate to the directory:
    ```bash
    cd dotfiles
    ```
3. Execute the `setup.sh` script:
   Ensure the script has executable permissions. If not, you can grant them using:
    ```bash
    chmod +x setup.sh
    ```
   Then run the script:
    ```bash
    ./setup.sh
    ```

## Troubleshooting

There is a diagnositc tool that is included that will allow you to check if you have all the prerequisites to run the setup:
```bash
 ./tools/diagnostic.sh
```

## Contributing

Feel free to submit issues or pull requests to improve these configurations.

## License

This project is licensed under the MIT License.
