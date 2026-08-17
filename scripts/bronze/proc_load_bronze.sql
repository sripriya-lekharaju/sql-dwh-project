/*
===================================================================
Stored Procedure: Load Bronze layer (Source-> Bronze)
===================================================================
Script Purpose:
   this stored procedure loads data into 'bronze schema from external .csv files
it performs the following actions
      -Truncates the bronze tables before loading the data
      -Uses the 'Bulk insert' command to load data from csv files to bronze tables

Parameters:
  None.
  This stored procedure does not accept any parameters or return any values

Usage example:
  EXEC bronze.load_bronze
===================================================================
*/


CREATE or ALTER PROCEDURE bronze.load_bronze AS
	BEGIN

		DECLARE @start_time DATETIME,@end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
		BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '===================================================================';
		PRINT 'Loading the bronze layer';
		PRINT '===================================================================';


		/* Inserting the data from .csv files of crm source system into the respective tables */
		PRINT '-----------------------------------------------------------------------';
		PRINT 'Loading CRM tables';
		PRINT '-----------------------------------------------------------------------';



		PRINT '-----------------------------------------------------------------------';
		SET @start_time = GETDATE();
		PRINT '>>>Truncating table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info
		PRINT '>> Inserting table:  bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\sripr\OneDrive\Documents\Data with baraa projects\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW =2	,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'



		PRINT '-----------------------------------------------------------------------';
		SET @start_time = GETDATE();
		PRINT '>>>Truncating table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info
		PRINT '>> Inserting table:bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\sripr\OneDrive\Documents\Data with baraa projects\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW =2	,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '-----------------------------------------------------------------------';


																														

		PRINT '-----------------------------------------------------------------------';
		SET @start_time = GETDATE();
		PRINT '>>>Truncating table:bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details
		PRINT '>> Inserting table:bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\sripr\OneDrive\Documents\Data with baraa projects\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'

		WITH (
			FIRSTROW =2	,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '-----------------------------------------------------------------------';

		/* Inserting the data from .csv files of erp source system into the respective tables */

		PRINT '*************************************************************************************';
		PRINT 'Loading ERP tables';
		PRINT '*************************************************************************************'


		PRINT '-----------------------------------------------------------------------';
		SET @start_time = GETDATE();
		PRINT '>>>Truncating table:bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12
		PRINT '>> Inserting table:bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\sripr\OneDrive\Documents\Data with baraa projects\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW =2	,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);

		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '-----------------------------------------------------------------------';


		SET @start_time = GETDATE();
		PRINT '>>>Truncating table:bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101
		PRINT '>> Inserting table:bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\sripr\OneDrive\Documents\Data with baraa projects\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW =2	,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '-----------------------------------------------------------------------';


		SET @start_time = GETDATE();
		PRINT '>>>Truncating table:bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		PRINT '>> Inserting table:bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\sripr\OneDrive\Documents\Data with baraa projects\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW =2	,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '-----------------------------------------------------------------------';
			SET @batch_end_time = GETDATE();
			PRINT '================================================='
			PRINT 'Batch duration : ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds'
			PRINT '================================================='
			END TRY
			BEGIN CATCH
			PRINT '================================================='
			PRINT 'Error occured while loading bronze layer'
			PRINT 'Error message: ' + ERROR_MESSAGE();
			PRINT 'Error number: ' + CAST ( ERROR_number() AS NVARCHAR);
			PRINT 'Error state: ' + CAST (ERROR_STATE() AS NVARCHAR);

			PRINT '================================================='
							
			END CATCH

	END
