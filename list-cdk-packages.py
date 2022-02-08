#!/usr/bin/env python3

import fnmatch
import re
import requests
import sys
from bs4 import BeautifulSoup

def log(message, **kwargs):
    """Helper function to log diagnostic messages to stderr"""

    print(message, file=sys.stderr, **kwargs)

# Unpack the CDK version
cdk_version = sys.argv[1]

# Create a requests session for connection pooling
http = requests.Session()

# Request the entire PyPI package index
log('Fetching PyPI index', end='')
pypi_response = http.get('https://pypi.python.org/simple/')
log(' ... done')

# Configure to parse HTML document
log('Parsing response', end='')
soup = BeautifulSoup(pypi_response.text, 'html.parser')
log(' ... done')

# Regex pattern for parsing package URLs
pattern = '/simple/aws-cdk-(?P<package>.*)/'

# Packages to ignore
ignored_packages = [
    'aws-quickstarts', # Does not track CDK core
]

# Iterate <a> elements that link to packages
for package_link in soup.find_all('a'):
    url = package_link.get('href')

    # Using filename style pattern matching to identify AWS CDK modules
    if fnmatch.fnmatch(url, '/simple/aws-cdk-aws*'):
        # Parse package name
        matches = re.search(pattern, url)

        # Ignore if no match can be made
        if matches is None:
            continue

        # Fetch available package versions
        pypi_version_list = http.get(f'https://pypi.python.org{url}').text

        # Match version
        if cdk_version in pypi_version_list:
            # Get package name from match
            package_name = matches.group('package')

            # Ignore if the package ends in -api
            if package_name.endswith('-api'):
                log(f'Ignoring {package_name}')
                continue

            # Ignore selected packages
            if package_name in ignored_packages:
                log(f'Ignoring {package_name}')
                continue

            # Print out package spec suitable for Pip
            package_requirement = f"aws-cdk.{package_name} == {cdk_version}"
            print(package_requirement)
            log(package_requirement)