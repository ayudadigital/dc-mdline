# Docker Command: Markdown timeline format generator

Convert files from Markdown format to timeline HTML format

Its a part of the Docker Command series

## Usage

Execute the following within your repository folder:

- Using Bash: `entrypoint.sh source.md > target.html`
- Using Docker: `docker run --rmi -v $(pwd):/workspace ayudadigital/dc-mdline source.md > target.html`
- Using docker-command-launcher: `kd mdline source.md > target.html`

## Considerations

This function uses the `mdline` node package. You could install it using node with `npm install mdline -g`
