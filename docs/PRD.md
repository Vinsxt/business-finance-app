# PRD — Business Finance App

**Platform:** iOS  
**Framework:** SwiftUI  
**Backend:** Supabase + PostgreSQL  
**Authentication:** Supabase Auth  
**Target Users:** Internal Finance Team and Business Partners  
**Project Type:** Internal Financial Management System for a Car Showroom

---

# 1. Product Overview

Build an internal iOS financial management application for a car showroom, replacing the existing Excel-based bookkeeping system while preserving its financial structure, calculations, and workflows.

The application enables the finance team to manage partner-specific financial books, monitor vehicle inventory, track transactions, calculate monthly profits, manage pending customer payments, record vehicle costing, and reconcile financial balances.

Business partners can access their respective books and contribute information to the system.

The application must prioritize:
- Financial accuracy.
- Data consistency.
- Role-based access control.
- Data isolation between partners.
- Auditability.
- Efficient manual data entry.
- Professional financial reporting and exports.

# 2. Core Business Rules

1. Only finance team members can edit official financial books.
2. Every partner has exactly one financial book.
3. Each partner's financial book operates independently.
4. Financial books are organized by month.
5. Each book supports daily and monthly closing.
6. Existing Excel structure and column ordering are the primary reference.
7. When the same information appears on different Excel pages, finance must enter it separately unless explicitly specified otherwise.
8. Vehicle information is generally received through WhatsApp and manually entered.
9. SOLD status is assigned when a customer makes a DP payment.
10. Profit is recognized only after the customer has fully paid.
11. Customer Debt = Sell Price - Current Payment.
12. Costing Awaiting Full Payment is manually maintained.
13. Stock valuation and pending funds are separate financial categories.
14. All financial modifications must be auditable.
15. Users can only access financial books permitted by their assigned role.

# 3. User Roles & Access Control

The application has two primary roles.

## 3.1 Finance Team

Finance team members have access to all partner books.

Permissions:
- View all partner books.
- Switch between partner books.
- Create and edit financial records.
- Manage vehicle stock.
- Manage monthly profit.
- Manage pending funds.
- Manage costing.
- Manage bank transactions.
- Manage Limit Checker.
- Perform daily and monthly closing.
- Export financial data.
- Create and manage user accounts.
- Review audit logs.
- Manage partner information.

## 3.2 Business Partners

Each partner is associated with exactly one financial book.

Permissions:
- View their own financial book.
- View their own financial reports.
- View their own vehicle stock.
- View their own pending funds.
- View their own monthly profit.
- View their own transactions.
- View their own Limit Checker.
- Submit or add permitted business information.
- Access their own historical financial records.

Restrictions:
- Cannot access another partner's book.
- Cannot view another partner's financial information.
- Cannot edit official financial records maintained by finance.
- Cannot manage users.
- Cannot modify financial closing records.
- Cannot change their assigned partner identity.
- Cannot access administrative functions.

**Important:** Partner-submitted information must be distinguishable from official finance records.

Partner submissions should have an appropriate review or approval process before becoming official financial records.

# 4. User Authentication & Account Management

This is an internal application. Public user registration is not required.

## 4.1 Account Creation

New accounts are manually created by authorized finance administrators.

Each user receives:
- Unique User ID.
- Password.
- Assigned Role.
- Assigned Partner (for partner accounts).
- Account Status (Active / Disabled).

Example:

| User ID | Role | Partner Access |
|---|---|---|
| FIN001 | Finance | All Partners |
| FIN002 | Finance | All Partners |
| PRT001 | Partner | Partner A |
| PRT002 | Partner | Partner B |

## 4.2 Login

The login screen requires:
- User ID.
- Password.

Authentication requirements:
- Validate credentials against the authentication system.
- Passwords must be securely hashed using an established authentication provider.
- Never store plaintext passwords.
- Never implement custom password hashing.
- Maintain authenticated sessions.
- Support logout.
- Support password changes and administrative password resets.
- Disabled accounts must not be able to authenticate.

Recommended implementation: Supabase Auth.

Since Supabase Auth natively supports email/password authentication, implement User ID login through a secure server-side identity mapping to the user's authentication identity.

Never expose Supabase service-role credentials in the iOS application.

## 4.3 Authorization

Authorization must be enforced on the backend, not merely by hiding buttons in SwiftUI.

Use PostgreSQL Row Level Security (RLS).

Rules:
- Finance users can access all partner books.
- Partner users can only access records associated with their assigned partner ID.
- Partners cannot change their own role or partner assignment.
- All write operations must validate permissions.
- Unauthorized database requests must be rejected.

The iOS UI should also reflect the user's role by displaying only permitted features.

# 5. Application Structure

Main application modules:

1. Dashboard
2. Partner Books
3. Monthly Profit
4. Vehicle Stock
5. Pending Funds
6. Costing
7. Bank Transactions (TRX)
8. Limit Checker
9. Book Closing
10. Data Export
11. User Management
12. Settings

# 6. Financial Modules

## 6.1 Monthly Profit

Records vehicles whose payments have been fully settled.

Fields:
- Date of Purchase.
- Date Sold.
- Brand.
- Car Name.
- Plate Number.
- Manufacturing Year.
- Buy Price.
- Costing Price.
- Sell Price.
- Total Profit.
- Profit 50%.

Formulas:

`Total Profit = Sell Price - (Buy Price + Costing Price)`

`Profit 50% = Total Profit / 2`

Rules:
- Profit is recognized only after full payment.
- Profit recognition month is determined by the date of full payment.
- Original sale date must remain unchanged.
- Vehicles with outstanding customer payments must not appear as recognized profit.
- Support monthly filtering and historical reports.

## 6.2 Vehicle Stock

Fields:
- Purchase Date.
- Brand.
- Car Name.
- Plate Number.
- Manufacturing Year.
- Buy Price.
- Costing Price.
- Notes.

Rules:
- Manage active vehicle inventory.
- Calculate total purchase value.
- Calculate total costing.
- When DP is received, move the vehicle out of active stock.
- Preserve historical vehicle records.
- A vehicle must not simultaneously exist in active Stock and Pending Funds.

## 6.3 Pending Funds

Fields:
- Brand.
- Car Name.
- Plate Number.
- Manufacturing Year.
- Buy Price.
- Current Payment.
- Customer Debt.
- Sell Price.

Formula:

`Customer Debt = Sell Price - Current Payment`

Rules:
- Record DP.
- Record additional customer payments.
- Maintain payment history.
- Recalculate outstanding customer debt.
- SOLD status remains assigned after DP.
- Remove from active Pending Funds when fully paid.
- Recognize profit only after full payment.

## 6.4 Costing

Fields:
- Car Purchase Date.
- Vehicle Information.
- Status (Sold / Not Sold).
- Octospector.
- Employee Commission.
- Services.
- Other Costing.
- Total Costing.
- Total Capital per Car.

Formulas:

`Total Costing = Sum of All Costing Items`

`Total Capital = Buy Price + Total Costing`

Support multiple costing entries per vehicle.

## 6.5 Bank Transactions (TRX)

Fields:
- Description.
- Transaction Date.
- Transaction Amount.
- Transaction Type (Money In / Money Out).
- Running Balance.
- Transaction Evidence.

Requirements:
- Record incoming and outgoing money.
- Automatically calculate running balances.
- Maintain transaction history.
- Support Google Drive evidence links.
- Organize evidence by transaction date.
- Filter by transaction date and type.

## 6.6 Limit Checker

Each partner has an independent Limit Checker.

Variables:
- Total Cars Price (In Stock).
- Total Costing Price (In Stock).
- Available Funds on Account.
- Pending Funds from Customer.
- Circulating Funds.
- Costing Awaiting Full Payment.

Costing Awaiting Full Payment is a manual input.

Formulas:

`Total Expected Funds = Circulating Funds + Total Recognized Profit`

`Total Actual Funds = Total Cars Price + Total Costing Price + Available Funds on Account + Pending Funds + Costing Awaiting Full Payment`

`Financial Difference = Total Expected Funds - Total Actual Funds`

Expected result:

`Financial Difference = 0`

Preserve the distinction between manually maintained and automatically calculated values.

# 7. Critical Workflow — Vehicle Purchase DP Received

Example:

Toyota Vellfire:
- Buy Price: Rp400,000,000.
- Costing: Rp10,000,000.
- Sell Price: Rp450,000,000.
- Customer DP: Rp5,000,000.

### Step 1: Record TRX

Create incoming transaction of Rp5,000,000.

### Step 2: Move Vehicle to Pending Funds

- Remove from active stock.
- Create Pending Funds record.
- Current Payment: Rp5,000,000.
- Customer Debt: Rp445,000,000.
- Assign SOLD status.

### Step 3: Monthly Profit

Do not recognize profit yet.

The vehicle has been sold commercially but is not fully paid.

### Step 4: Update Limit Checker

- Update Available Funds.
- Update manual Costing Awaiting Full Payment if applicable.
- Maintain manual values according to Excel.
- Recalculate relevant financial balances.

### Step 5: Financial Reconciliation

Check the financial difference.

All related database changes should be atomic.

# 8. Payment Completion Workflow

When the customer completes payment:

1. Record incoming payment in TRX.
2. Update Current Payment.
3. Recalculate Customer Debt.
4. Verify Customer Debt equals zero.
5. Remove the vehicle from active Pending Funds.
6. Create its Monthly Profit record.
7. Recognize profit in the month of full payment.
8. Calculate Total Profit and Profit 50%.
9. Update Limit Checker.

Preserve the original purchase date and sale date.

# 9. Daily and Monthly Book Closing

## Daily Closing

Capture:
- Incoming transactions.
- Outgoing transactions.
- Ending bank balance.
- Stock valuation.
- Pending funds.
- Costing.
- Financial reconciliation difference.

## Monthly Closing

Capture:
- Monthly profit.
- Profit 50%.
- Total transactions.
- Ending bank balance.
- Stock valuation.
- Pending funds.
- Total costing.
- Final Limit Checker.
- Financial discrepancy.

Closed books must be protected against unauthorized modifications.

Reopening requires finance authorization and an audit record.

# 10. Data Export

The application must support exporting financial information into two formats:

1. CSV (.csv)
2. Excel Workbook (.xlsx)

This is an important feature because the business currently relies on Excel for financial reporting.

## 10.1 Export Scope

Finance team can export:
- Individual partner books.
- All partner books.
- Selected monthly books.
- Monthly Profit.
- Vehicle Stock.
- Pending Funds.
- Costing.
- Bank Transactions (TRX).
- Limit Checker.
- Daily Closing.
- Monthly Closing.

Partners can export only their own permitted financial data.

## 10.2 CSV Export

Requirements:
- Export selected module data.
- Preserve column names.
- Preserve column ordering based on the existing Excel structure.
- Use consistent date formatting.
- Use numeric currency values without introducing calculation errors.
- Support UTF-8 encoding.
- Use appropriate CSV escaping for commas, quotes, and line breaks.

## 10.3 Excel Export

Excel export should be professionally formatted.

Requirements:
- Create separate worksheets for each financial module.
- Preserve the existing Excel column structure.
- Include clear worksheet names.
- Format currency as Indonesian Rupiah (IDR).
- Format dates consistently.
- Include column headers.
- Apply appropriate column widths.
- Freeze header rows.
- Enable filters.
- Highlight totals and important financial figures.
- Include monthly and partner identification.
- Include calculation summaries where applicable.
- Maintain readable layouts suitable for management reporting.

Example workbook structure:

`Finance_PartnerA_November_2026.xlsx`

Worksheets:
1. Monthly Profit
2. Vehicle Stock
3. Pending Funds
4. Costing
5. Bank Transactions
6. Limit Checker
7. Daily Closing
8. Monthly Closing

CSV files may be exported individually for each module because CSV does not support multiple worksheets.

## 10.4 Export Interface

Provide an Export screen with:
- Partner selection.
- Month selection.
- Module selection.
- File format selection (CSV / XLSX).
- Export button.

Finance can select all partners or individual partners.

Partners are restricted to their own book automatically.

## 10.5 Export Security

- Only export records the authenticated user is authorized to access.
- Never export data belonging to unauthorized partners.
- Do not include passwords, authentication tokens, or internal security information.
- Export operations should be logged.
- Exported files should contain a generation timestamp.

## 10.6 Implementation

Recommended implementation:
- CSV generation using native Swift functionality.
- XLSX generation using a suitable Excel-writing library or a dedicated backend export service.
- Exported files should be generated locally or through a secure backend process.
- Provide the native iOS share sheet to save or share generated files.

# 11. Technical Architecture

## iOS

- Swift.
- SwiftUI.
- MVVM or another well-structured architecture.
- Reusable components.
- Separated business logic.
- Centralized financial calculation services.
- Proper loading, error, and empty states.

## Backend

Recommended: Supabase + PostgreSQL.

Use:
- Supabase Auth for authentication.
- PostgreSQL for relational financial data.
- Row Level Security for authorization.
- Database transactions for complex financial workflows.
- Database functions or RPC for critical multi-step operations.
- Audit logs for financial modifications.

## Suggested Database Entities

1. Users / Profiles
2. Partners
3. FinancialBooks
4. BookClosings
5. Vehicles
6. StockRecords
7. ProfitRecords
8. PendingFunds
9. CustomerPayments
10. CostingRecords
11. CostingItems
12. BankTransactions
13. LimitCheckerRecords
14. PartnerSubmissions
15. AuditLogs
16. ExportLogs

Important:
- Each financial record must be associated with a partner.
- Each partner must have exactly one financial book.
- Vehicles must retain persistent identity throughout their lifecycle.
- Separate official financial records from partner submissions.
- Use appropriate decimal/numeric types for currency.
- Enforce partner-level isolation at database level.

# 12. Auditability and Data Integrity

Requirements:
- Maintain audit logs for financial changes.
- Record who created or modified a record.
- Record modification timestamps.
- Preserve historical financial data.
- Avoid permanently deleting important financial records.
- Use soft deletion or reversal records where appropriate.
- Prevent duplicate payment submissions.
- Validate financial calculations on the backend.
- Ensure multi-step operations are atomic.
- Maintain historical book-closing snapshots.

# 13. UI/UX Requirements

Design a modern native iOS financial management application.

Priorities:
1. Clear financial information hierarchy.
2. Fast manual data entry.
3. Easy navigation between partner books.
4. Familiar Excel-like tables.
5. Clear daily and monthly filtering.
6. Simple vehicle lifecycle management.
7. Clear transaction indicators.
8. Visible financial discrepancy warnings.
9. Professional financial reports.
10. Consistent IDR currency formatting.

Finance users should see all partner books.

Partner users should only see their own book and permitted submission functions.

# 14. Acceptance Criteria

The application is functional when:

### Authentication
- Users can log in using assigned ID and password.
- Accounts are manually provisioned.
- Roles are enforced.
- Disabled accounts cannot log in.
- Partners cannot access other partner books.

### Financial Management
- Finance can manage all partner books.
- Partners can view their own books.
- Permitted partner submissions are supported.
- Vehicle Stock works correctly.
- Costing calculations work correctly.
- Pending Funds calculations work correctly.
- Monthly Profit recognition follows full payment.
- TRX running balances are correct.
- Limit Checker calculations are correct.
- Daily and monthly closing work correctly.

### Export
- Finance can export all authorized partner data.
- Partners can export only their own authorized data.
- CSV files are generated correctly.
- XLSX workbooks contain properly formatted worksheets.
- Exported data preserves the original Excel structure.

### Security
- Backend authorization is enforced through RLS.
- Sensitive credentials are never exposed.
- Financial modifications are auditable.
- Unauthorized requests are rejected.

# 15. Development Instructions for Coding Agents

Before implementation:

1. Analyze the entire PRD.
2. Identify business logic ambiguities.
3. Propose a normalized PostgreSQL database schema.
4. Define entity relationships.
5. Design authentication and role-based access control.
6. Define partner-level RLS policies.
7. Define the vehicle lifecycle and financial state transitions.
8. Define financial formulas and reconciliation rules.
9. Design the export architecture for CSV and XLSX.
10. Present the architecture and implementation plan before major implementation.

During implementation:

- Keep UI, business logic, and data access separate.
- Centralize financial calculations.
- Never hardcode partner-specific values.
- Never trust client-side authorization alone.
- Do not store plaintext passwords.
- Never expose Supabase service-role keys.
- Preserve historical financial data.
- Implement unit tests for financial calculations.
- Implement integration tests for critical workflows.
- Test partner data isolation.
- Test export permissions.
- Use realistic mock data during development.

## Recommended Development Priority

1. Database schema and business logic.
2. Authentication and user management.
3. Role-based authorization and RLS.
4. Partner books and data isolation.
5. Vehicle Stock.
6. Costing.
7. TRX.
8. Pending Funds.
9. Monthly Profit.
10. Limit Checker.
11. Daily and Monthly Closing.
12. CSV and XLSX Export.
13. Dashboard and UI refinement.

**Final Objective:**

Build a secure, reliable, multi-user financial management system that replaces the existing Excel workflow while allowing finance teams and business partners to collaborate within clearly defined access permissions.
