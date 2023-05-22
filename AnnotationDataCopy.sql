SELECT R1.AnnotationID
    ,ACM2.AnnotationCustomMetaDataID
,R1.Value1
 ,R1.Value2
 ,R1.Value3
 ,R1.Value4
 ,R1.Value5
 ,R1.Value6
 ,R1.Value7
 ,R1.Value8

FROM (
        SELECT AC.AnnId AS AnnotationID
        ,AC.Value1
        ,AC.Value2
        ,AC.Value3
        ,AC.Value4
        ,AC.Value5
        ,AC.Value6
        ,AC.Value7
        ,AC.Value8
        ,AnnotationTypeID = 27
        ,ACM.FieldName
        ,ACM.FieldType    
    FROM (
                SELECT AC2.*
            ,(
                SELECT TOP 1 AnnotationID
                FROM [tenant].Annotation
                WHERE AnnotationTypeID = 27
                    AND DealID = A.DealID
                    AND Description = A.Description
                    AND FullDescription = A.FullDescription
                ) AnnId         
        FROM [tenant].AnnotationCustom AC2
        INNER JOIN [tenant].Annotation A ON AC2.AnnotationID = A.AnnotationID        
        WHERE AC2.AnnotationID IN (
                SELECT a.AnnotationID
                FROM [tenant].Annotation A
                WHERE A.AnnotationTypeID = 8
                )    
        )     AC
    INNER JOIN [tenant].AnnotationCustomMetaData ACM ON AC.AnnotationCustomMetaDataID = ACM.AnnotationCustomMetaDataID
    ) R1
INNER JOIN [tenant].AnnotationCustomMetaData ACM2 ON R1.FieldType = ACM2.FieldType
    AND R1.FieldName = ACM2.FieldName
    AND ACM2.AnnotationTypeID = 27