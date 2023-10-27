terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.22.0"
    }
  }
}

provider "aws" {
  region     = "us-east-2"
  access_key = "AKIAYY3IKT3ZPUSXV4QJ"
  secret_key = "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"
}

