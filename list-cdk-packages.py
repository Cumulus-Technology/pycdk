#!/usr/bin/env python3

import fnmatch
import re
import requests
import sys
from bs4 import BeautifulSoup

# Request the entire PyPI package index
print('Fetching PyPI index', file=sys.stderr, end='')
pypi_response = requests.get('https://pypi.python.org/simple/')
print(' ... done', file=sys.stderr)

# Configure to parse HTML document
print('Parsing response', file=sys.stderr, end='')
soup = BeautifulSoup(pypi_response.text, 'html.parser')
print(' ... done', file=sys.stderr)

# Regex pattern for parsing package URLs
pattern = '/simple/aws-cdk-(?P<package>.*)/'

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

        package_name = matches.group('package')

        # Ignore if the package ends in -api
        if package_name.endswith('-api'):
            continue

        # Ignore selected packages that are not tracking CDK core
        if package_name in ['aws-quickstarts']:
            continue

        # Print out package spec suitable for Pip
        print(f"aws-cdk.{matches.group('package')}=={sys.argv[1]}", end=' ')
    