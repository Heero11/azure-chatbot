# Azure Chatbot

A cloud-based RAG chatbot deployed on Microsoft Azure. The application allows users to create conversations, upload PDF documents, and ask questions based on the uploaded content.

## Overview

The application uses a Streamlit interface, a FastAPI backend, and ChromaDB for vector storage. Documents are processed into embeddings and stored in ChromaDB, allowing the chatbot to retrieve relevant information when answering questions.

The application is containerized with Docker and deployed on an Azure Linux Virtual Machine. Terraform is used to provision the Azure infrastructure, while GitHub Actions automates Docker image builds and deployment.

## Architecture

```text
User
  |
  v
Streamlit Chatbot
  |
  v
FastAPI Backend
  |
  +----> ChromaDB
  |
  +----> PostgreSQL
  |
  +----> Azure Blob Storage
  |
  +----> OpenAI API
  |
  +----> Azure Key Vault
           ^
           |
    Managed Identity
           ^
           |
      Azure VM


```
## Technologies

### Application
- Python
- FastAPI
- Streamlit
- LangChain
- OpenAI
- ChromaDB
- PostgreSQL

### Azure
- Azure Virtual Machine
- Azure Virtual Network
- Network Security Group
- Azure Key Vault
- Azure Blob Storage
- Managed Identity

### Infrastructure & DevOps
- Terraform
- Docker
- Docker Compose
- GitHub Actions
- Docker Hub

## Key Features

- Create and manage chatbot conversations
- Upload PDF documents
- Ask questions about uploaded documents using RAG
- Store chat data in PostgreSQL
- Store PDF files and chat history in Azure Blob Storage
- Generate and retrieve document embeddings using ChromaDB
- Stream chatbot responses
- Secure application secrets using Azure Key Vault
- Access Key Vault through the VM's system-assigned managed identity
- Automated Docker image build and deployment using GitHub Actions

## Security

Application secrets such as database credentials, the OpenAI API key, and Azure Storage credentials are stored in Azure Key Vault rather than directly in the application code.

The Azure Virtual Machine uses a system-assigned managed identity with the **Key Vault Secrets User** role to retrieve the required secrets.

No application secrets are stored in the GitHub repository.

## Project Structure

```text
.
├── .github/
│   └── workflows/
│       ├── deploy.yml
│       └── docker-build-push.yml
├── backend.py
├── chatbot.py
├── docker-compose.yaml
├── Dockerfile.backend
├── Dockerfile.chatbot
├── keyvault.tf
├── main.tf
├── network.tf
├── requirements.txt
├── update_app.sh
├── variables.tf
├── vm.tf
└── .gitignore
```
```
