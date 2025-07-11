                                  -- Data Analysis
						
                        
SELECT MAX(total_laid_off), MAX(percentage_laid_off) 
FROM layoffs_staging2;

SELECT * FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT * FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`) 
FROM layoffs_staging2;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT MONTH(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY MONTH(`date`)
ORDER BY 1 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT company, SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT * FROM layoffs_staging2;

SELECT substring(`date`,1,7) AS `Month`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE substring(`date`,6,2) IS NOT NULL
GROUP BY `Month` 
ORDER BY 2 DESC;

WITH Rolling_Total AS
( SELECT substring(`date`,1,7) AS `Month`, SUM(total_laid_off) AS Total
FROM layoffs_staging2
WHERE substring(`date`,6,2) IS NOT NULL
GROUP BY `Month` 
ORDER BY 1 ASC)
                                  
   SELECT `Month`, Total,  SUM(Total) OVER (ORDER BY `Month`)  AS Rolling_Total 
   FROM Rolling_Total;
                                  
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

WITH Rolling_Total AS
( SELECT company, YEAR(`date`) AS `YEAR`, SUM(total_laid_off) As Total
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC)

SELECT company, `YEAR`,Total,  SUM(Total) OVER (ORDER BY company, `YEAR`) AS Rolling_Total
FROM  Rolling_Total;

WITH Company_Year(company, years, total_laid_off) AS
( SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC),

Company_Year_Rank AS
( SELECT *, 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM  Company_Year
WHERE years IS NOT NULL

)
SELECT * FROM Company_Year_Rank
WHERE Ranking <= 5;


