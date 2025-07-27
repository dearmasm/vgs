# vgs
VGS Data Tokenization API use cases

## Setup
Configure VGS account user ID and password credentials as environmental exports:
```python
> export VGS_USERID=<my-vgs-userid>
> export VGS_PASSWORD=<my-vgs-password>
```

## Optional Configuration
Scripts will default to use VGS alias format of "UUID" but can be changed to use other formats by setting this environment variable:
```python
> export VGS_TOKEN_ALIAS_FORMA=<vg-alias-format>
```
Reference VGS different formats (and input value requirements/limitations) here: https://www.verygoodsecurity.com/docs/vault/concepts/tokens#alias-formats

## Usage (CLI)

```python
> ./tokenize.sh value1:classifier1 [value2:classifier2 ...]
```

```python
> ./detokenize.sh token1[,token2,...]
```


## API Schema


## API Routes & Proxies
Besides the usual direct API interaction your application can have with tokenization API use cases, VGS also supports enabling transactional proxies (intermediaries) that can handle securing PCI or sensitive information during transactions with 3rd party providers (e.g. PSPs).

VGS proxies route data for various data transmission protocols, including HTTPS, SFTP, FTPS, and SMTP. VGS Routes are payload-agnostic and can transform any binary or text-based payload, including JSON, XML, HTML, PDFs, and compressed files.

They also support proxying device communications built on ISO8583 POS/ATM messaging standards and support proxying 3270 Mainframe and other telnet based protocols.
