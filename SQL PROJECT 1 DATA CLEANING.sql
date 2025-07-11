Select * from layoffs;

                   -- Removing Duplicates 

CREATE TABLE layoffs_staging like layoffs;

SELECT * FROM layoffs_staging;

INSERT layoffs_staging
SELECT * FROM layoffs;


SELECT *, 
ROW_NUMBER() OVER( 
PARTITION BY company, location, industry, totaL_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions ) AS row_num
FROM layoffs_staging;

WITH cte_duplicate AS
(SELECT *, 
ROW_NUMBER() OVER( 
PARTITION BY company, location, industry, totaL_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions ) AS row_num
FROM layoffs_staging)

SELECT * FROM cte_duplicate WHERE row_num>1;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *, 
ROW_NUMBER() OVER( 
PARTITION BY company, location, industry, totaL_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions ) AS row_num
FROM layoffs_staging;

DELETE FROM layoffs_staging2 WHERE row_num>1;

SELECT * FROM layoffs_staging2 WHERE row_num>1;


                    -- Data Standardization


SELECT company, TRIM(company) FROM layoffs_staging2;

UPDATE layoffs_staging2 
SET company= TRIM(company);

SELECT *
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2 where industry LIKE 'Crypto%';

UPDATE layoffs_staging2 
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2 
SET country = TRIM(TRAILING '.' FROM 'United States')
WHERE country LIKE 'United States%';

SELECT DISTINCT(country)
FROM layoffs_staging2 ORDER BY 1;

SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date`= STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY `date` DATE;

                                 -- Removing Null/ Blank Values
                         
SELECT * from layoffs_staging2  
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL ;    

SELECT * from  layoffs_staging2      
WHERE industry IS NULL OR industry= '';

SELECT * FROM layoffs_staging2
WHERE company = 'Juul';

UPDATE layoffs_staging2 
SET industry= NULL 
WHERE industry = '';

SELECT * FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company= t2.company
WHERE (t1.industry IS NULL)
AND t2.industry IS NOT NULL; 

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company= t2.company
SET t1.industry=t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL; 
                         
SELECT *
FROM layoffs_staging2;

  


                                  -- Removing unnecessary columns and rows 
                                  
SELECT * from layoffs_staging2  
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL ;  

DELETE from layoffs_staging2  
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL ;  		

SELECT * FROM layoffs_staging2;

ALTER table layoffs_staging2 
DROP COLUMN row_num;			





