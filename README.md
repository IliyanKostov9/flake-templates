# NixOS flake templates using devenv

## Abstract
This project complements the devenv flake-parts usage by adding dependencies depending on the programmnig language the developer uses.

## Available languages

1. Java
2. Javascript
3. Python
4. Go
5. Terraform
6. None (empty)

## Commands to install the templates

### Java

```bash
 nix flake init --template github:IliyanKostov9/flake-templates#java
```

### Python

```bash
 nix flake init --template github:IliyanKostov9/flake-templates#python
```

### Go

```bash
 nix flake init --template github:IliyanKostov9/flake-templates#go
```

### Javascript

```bash
 nix flake init --template github:IliyanKostov9/flake-templates#javascript
```

### Terraform

```bash
 nix flake init --template github:IliyanKostov9/flake-templates#terraform
```

### Empty

```bash
 nix flake init --template github:IliyanKostov9/flake-templates#empty
```
