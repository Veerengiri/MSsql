### Brief Approach for Solving Tasks

#### 1. Database Design and Creation
- **Normalization**: Tables were normalized with Primary and Foreign Keys for referential integrity.
- **Schema**: Authors, Categories, Books, Orders, and OrderDetails tables were created with appropriate relationships.

#### 2. Data Insertion
- **Realistic Data**: Added popular authors, meaningful book titles, relevant categories, and sample orders with quantities.

#### 3. Querying and Analysis

##### Basic Queries:
- **Books with Authors and Categories**: Used JOINs to fetch related data.
- **Out of Stock Books**: Applied WHERE clause on StockQuantity.

##### Aggregate Functions:
- **Total Revenue**: Calculated as SUM of price multiplied by quantity.
- **Books by Category**: Grouped by CategoryName with SUM of StockQuantity.

##### Joins:
- **Orders with Details**: Combined Orders, OrderDetails, and Books data using JOINs.

##### Subqueries:
- **Most Expensive Science Book**: Filtered by CategoryID with ORDER BY Price DESC.
- **Customers Ordering >5 Books**: Grouped by CustomerName and filtered using HAVING.

##### Advanced Queries:
- **High Revenue Authors**: Grouped by AuthorName and filtered with HAVING SUM > 500.
- **Top 3 Stock Value Books**: Calculated stock value and sorted using TOP 3.

##### Stored Procedures:
- **GetBooksByAuthor**: Created a procedure to retrieve books for a given AuthorID.

##### Views:
- **TopSellingBooks**: Displayed top 5 books by total quantity sold using a grouped view.

##### Indexes:
- **Books Title Index**: Optimized search with an index on the Title column.

Scripts are tested, error-free, and tailored for MSSQL.

