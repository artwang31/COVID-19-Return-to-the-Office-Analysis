SELECT DISTINCT A.EmployeeKey,
		A.JobTitle,
		B.WinNT_ID AS ADUserName,
		C.Division,
		B.Department
    FROM [HRISStaged].[dbo].[EmployeeJobTitle] A
    LEFT JOIN [MasterData].[dbo].[ADAccounts] B ON A.EmployeeKey = B.EmployeeID --Using LEFT JOIN because we know we have missing data fields
    CROSS JOIN [HRISStaged].[dbo].[EmployeeCorpGroup_Pivoted] C
    LEFT JOIN [HRISStaged].[dbo].[EmployeeStatus] D ON A.EmployeeKey = D.EmployeeKey
    WHERE D.StatusName = 'Active' AND
          (A.JobTitle = 'Associate Regional Superintendent' OR
	  A.JobTitle = 'Executive' OR
          A.JobTitle = 'Regional Superintendent' OR
          A.JobTitle = 'Regional Director' OR
	  A.EmployeeKey = '10522893' OR
	  A.EmployeeKey = 'EBMssFH2N9Q'  OR
	  A.EmployeeKey = '105dd895'  OR
	  A.EmployeeKey = '102ss628'  OR
	  A.EmployeeKey = 'PRUWaa3DISZ')
UNION
SELECT A.EmployeeKey,
       A.JobTitle,
       B.WinNT_ID AS ADUserName,
       C.Division,
       B.Department
    FROM [HRISStaged].[dbo].[EmployeeJobTitle] A
    LEFT JOIN [MasterData].[dbo].[ADAccounts] B ON A.EmployeeKey = B.EmployeeID --Using LEFT JOIN because we know we have missing data fields
    LEFT JOIN [HRISStaged].[dbo].[EmployeeCorpGroup_Pivoted] C ON A.EmployeeKey = C.EmployeeKey
    LEFT JOIN [HRISStaged].[dbo].[EmployeeStatus] D ON A.EmployeeKey = D.EmployeeKey
    WHERE D.StatusName = 'Active' AND
          (A.JobTitle LIKE '%Principal%' OR
          A.JobTitle LIKE '%Dean%' OR
          A.JobTitle = 'Director of School Ops')
UNION
SELECT DISTINCT A.EmployeeKey,
		A.JobTitle,
		B.WinNT_ID as ADUserName,
		--- Use Employee ID to add an exceptions school ---
		--- User below as template - paste in new line below green line below ---
		--- WHEN b.EmployeeID = '101sd747' ---
		CASE
                    WHEN B.EmployeeID = 'VV5KVasd1Q1E' THEN 'Company A'
                    --- Paste new exceptions here ---
                    WHEN B.EmployeeID = '1017asd05' THEN 'Company B'
                    ELSE C.Division
                END AS Division,
		C.Division as Department
	FROM [HRISStaged].[dbo].[EmployeeJobTitle] A
	LEFT JOIN [MasterData].[dbo].[ADAccounts] as B ON A.EmployeeKey = B.EmployeeID
	LEFT JOIN [HRISStaged].[dbo].[EmployeeCorpGroup_Pivoted] as C ON A.EmployeeKey = C.EmployeeKey
	LEFT JOIN [HRISStaged].[dbo].[EmployeeStatus] D ON A.EmployeeKey = D.EmployeeKey
	WHERE A.EmployeeKey IS NOT NULL AND
              D.StatusName = 'Active'
