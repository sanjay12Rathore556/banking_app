# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_181_016_202_514) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'accounts', force: :cascade do |t|
    t.string 'account_no'
    t.float 'balance'
    t.string 'account_type'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_accounts_on_user_id'
  end

  create_table 'atms', force: :cascade do |t|
    t.string 'name'
    t.string 'address'
    t.bigint 'bank_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['bank_id'], name: 'index_atms_on_bank_id'
  end

  create_table 'banks', force: :cascade do |t|
    t.string 'name'
    t.string 'contact_no'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'branches', force: :cascade do |t|
    t.string 'name'
    t.string 'address'
    t.string 'contact_no'
    t.string 'IFSC_code'
    t.bigint 'bank_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['bank_id'], name: 'index_branches_on_bank_id'
  end

  create_table 'loans', force: :cascade do |t|
    t.string 'loan_type'
    t.integer 'amount'
    t.integer 'interest'
    t.integer 'time_period'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_loans_on_user_id'
  end

  create_table 'managers', force: :cascade do |t|
    t.string 'name'
    t.string 'contact_no'
    t.bigint 'branch_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['branch_id'], name: 'index_managers_on_branch_id'
  end

  create_table 'transactions', force: :cascade do |t|
    t.integer 'amount'
    t.string 'transaction_type'
    t.bigint 'account_id'
    t.bigint 'atm_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['account_id'], name: 'index_transactions_on_account_id'
    t.index ['atm_id'], name: 'index_transactions_on_atm_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'father_name'
    t.string 'mother_name'
    t.string 'address'
    t.string 'contact_no'
    t.integer 'age'
    t.bigint 'branch_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['branch_id'], name: 'index_users_on_branch_id'
  end

  add_foreign_key 'accounts', 'users'
  add_foreign_key 'atms', 'banks'
  add_foreign_key 'branches', 'banks'
  add_foreign_key 'loans', 'users'
  add_foreign_key 'managers', 'branches'
  add_foreign_key 'transactions', 'accounts'
  add_foreign_key 'transactions', 'atms'
  add_foreign_key 'users', 'branches'
end
