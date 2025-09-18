# Snowflake Definitive Guide

*Last updated: September 18, 2025*

This repository contains SQL scripts, data files, and resources for learning and mastering Snowflake, based on the "Snowflake Definitive Guide". Each chapter folder includes example scripts and exercises to help users understand Snowflake features, best practices, and advanced topics.

## Structure
- **Chapter1 - Chapter8**: SQL scripts and exercises for each chapter
- **table20_data.csv**: Sample data for exercises

## Getting Started
1. Clone the repository
2. Explore chapter folders for SQL scripts
3. Use the provided data files for hands-on practice

## Topics Covered
- Snowflake architecture
- Access control
- Data loading and unloading
- Advanced SQL features
- Best practices

## License
This project is for educational purposes only.

## Enabling GitHub MCP

To enable GitHub Model Context Protocol (MCP) for this repository:

1. Go to your repository settings on GitHub.
2. Navigate to the "Actions" section and ensure GitHub Actions are enabled.
3. Add the required MCP workflow YAML file to your `.github/workflows` directory. Example:

```yaml
name: MCP Server
on:
	push:
		branches: [ main ]
jobs:
	mcp-server:
		runs-on: ubuntu-latest
		steps:
			- uses: actions/checkout@v3
			# Add MCP server setup steps here
```
4. Commit and push the workflow file.
5. Verify that the workflow runs successfully in the "Actions" tab.

For more details, refer to the official GitHub documentation for MCP and Actions.
