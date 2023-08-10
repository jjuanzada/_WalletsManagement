# Wallets Management API

Welcome to the Wallets Management documentation. This App allows you to manage users, virtual wallets, perform transactions, and retrieve transaction information for users.

## Getting Started

To get started with the API, follow these steps:

1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/jjuanzada/_WalletsManagement.git

2. Navigate to the project directory:
    ```bash
    cd _WalletsManagement

3. Install the required dependencies using Bundler:
    ```bash
    bundle install

4. Set up the database by running migrations:
    ```bash
    rails db:migrate

5. Start the Rails server:
    ```bash
    rails s

# API Endpoints
## Credit Transaction
Endpoint: `POST /api/v1/users/:user_id/transactions/credit`

Credit an amount to the user's virtual wallet.

## Debit Transaction
Endpoint: `POST /api/v1/users/:user_id/transactions/debit`

Debit an amount from the user's virtual wallet.

## Balance
Endpoint: `GET /api/v1/users/:user_id/transactions/balance`

Retrieve the current balance of the user's virtual wallet.

## User Transactions
Endpoint: `GET /api/v1/users/:user_id/transactions`

Retrieve transactions for a specific user within a specified time period.

## All Transactions
Endpoint: `GET /api/v1/transactions`

Retrieve all transactions across all users in a specified time period.
