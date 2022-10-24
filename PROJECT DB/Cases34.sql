USE ENTV
GO

-- 3 
SELECT  SUBSTRING(StaffName, 1, CHARINDEX(' ', StaffName) - 1) AS [StaffName],
        TelevisionName,
        t.TelevisionPrice * ptd.Quantity AS [Total Price]
FROM Staff s
JOIN PurchaseTransactionHeader pth
ON s.StaffID = pth.StaffID
JOIN PurchaseTransactionDetail ptd
ON ptd.PurchaseTransactionID = pth.PurchaseTransactionID
JOIN Television t 
ON t.TelevisionID = ptd.TelevisionID
WHERE TelevisionName LIKE '%UHD%' 
GROUP BY 

SELECT SUBSTRING(StaffName, 1, CHARINDEX(' ', StaffName) - 1) AS StaffName,
TelevisionName,
SUM (t.TelevisionPrice * ptd.Quantity) AS [Total Price]
FROM Staff s
JOIN PurchaseTransactionHeader pth
ON s.StaffID = pth.StaffID
JOIN PurchaseTransactionDetail ptd
ON ptd.PurchaseTransactionID = pth.PurchaseTransactionID
JOIN Television t 
ON t.TelevisionID = ptd.TelevisionID
WHERE TelevisionName LIKE '%UHD%' 
GROUP BY StaffName,TelevisionName,TelevisionPrice,Quantity
HAVING COUNT (pth.PurchaseTransactionID) > 2


-- 4
SELECT TelevisionName = UPPER(T.TelevisionName) , 
        CONCAT(MAX(Quantity), ' Pc(s)') AS [Max Television Sold],  
        CONCAT(SUM(Quantity), ' Pc(s)') AS [Total Television Sold] 
FROM Television T  
JOIN SalesTransactionDetail STD 
ON T.TelevisionID = STD.TelevisionID
JOIN SalesTransactionHeader STH 
ON STD.SalesTransactionID = STH.SalesTransactionID
WHERE DATENAME(MONTH, TransactionDate) > '2' 
AND TelevisionPrice > 3000000
GROUP BY T.TelevisionName
ORDER BY SUM(Quantity) ASC



