-- Create the new grid with flags and class breakdowns
WITH
-- Identify grid cells containing lakes
grid_with_lakes AS (
  SELECT 
    g.id, 
    MAX(CASE 
      WHEN ST_Intersects(g.geom, l.geom) THEN 1
      ELSE 0
    END) AS contains_lake
  FROM "public"."dkn_10km_etrs89" AS g
  LEFT JOIN "geodk"."soe" AS l
  ON ST_Intersects(g.geom, l.geom)
  AND st_area(l.geom) > 10000
  GROUP BY g.id
),

-- Identify grid cells which do not overlap the landpolygon
grid_no_overlap AS (
  SELECT 
    g.id, 
    1 AS no_overlap 
  FROM "public"."dkn_10km_etrs89" AS g 
  LEFT JOIN "public"."landpolygon" AS b 
  ON ST_Intersects(g.geom, b.geom) 
  WHERE b.geom IS NULL
),

-- Identify grid cells which partially overlap the landpolygon
grid_partial_overlap AS (
  SELECT 
    g.id, 
    1 AS partial_overlap 
  FROM "public"."dkn_10km_etrs89" AS g 
  JOIN "public"."landpolygon" AS b 
  ON ST_Overlaps(g.geom, b.geom)
),

-- Calculate percentage of each class in each grid cell
class_breakdown AS (
  SELECT
    g.id,
    SUM(CASE WHEN c."Class" = 1 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_1_percentage,
    SUM(CASE WHEN c."Class" = 2 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_2_percentage,
    SUM(CASE WHEN c."Class" = 3 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_3_percentage,
    SUM(CASE WHEN c."Class" = 4 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_4_percentage,
    SUM(CASE WHEN c."Class" = 5 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_5_percentage,
    SUM(CASE WHEN c."Class" = 6 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_6_percentage,
    SUM(CASE WHEN c."Class" = 7 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_7_percentage,
    SUM(CASE WHEN c."Class" = 8 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_8_percentage,
    SUM(CASE WHEN c."Class" = 9 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_9_percentage,
    SUM(CASE WHEN c."Class" = 10 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_10_percentage,
    SUM(CASE WHEN c."Class" = 11 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_11_percentage,
    SUM(CASE WHEN c."Class" = 12 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_12_percentage,
    SUM(CASE WHEN c."Class" = 16 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_16_percentage,
    SUM(CASE WHEN c."Class" = 18 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_18_percentage,
    SUM(CASE WHEN c."Class" = 20 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_20_percentage,
    SUM(CASE WHEN c."Class" = 21 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_21_percentage,
    SUM(CASE WHEN c."Class" = 23 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_23_percentage,
    SUM(CASE WHEN c."Class" = 24 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_24_percentage,
    SUM(CASE WHEN c."Class" = 25 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_25_percentage,
    SUM(CASE WHEN c."Class" = 26 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_26_percentage,
    SUM(CASE WHEN c."Class" = 27 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_27_percentage,
    SUM(CASE WHEN c."Class" = 29 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_29_percentage,
    SUM(CASE WHEN c."Class" = 30 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_30_percentage,
    SUM(CASE WHEN c."Class" = 33 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_33_percentage,
    SUM(CASE WHEN c."Class" = 35 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_35_percentage,
    SUM(CASE WHEN c."Class" = 36 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_36_percentage,
    SUM(CASE WHEN c."Class" = 37 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_37_percentage,
    SUM(CASE WHEN c."Class" = 39 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_39_percentage,
    SUM(CASE WHEN c."Class" = 41 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_41_percentage,
    SUM(CASE WHEN c."Class" = 42 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_42_percentage,
    SUM(CASE WHEN c."Class" = 44 OR c."Class" = 128 THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 ELSE 0 END) AS class_44_percentage,
    LEAST(
        SUM(
            CASE 
                WHEN c."Class" IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 16, 18, 20, 21, 23, 24, 25, 26, 27, 29, 30, 33, 35, 36, 37, 39, 41, 42, 44)
                THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 
                ELSE 0 
            END
        ), 100
    ) AS total_percentage,
    GREATEST(100 - LEAST(
        SUM(
            CASE 
                WHEN c."Class" IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 16, 18, 20, 21, 23, 24, 25, 26, 27, 29, 30, 33, 35, 36, 37, 39, 41, 42, 44)
                THEN (ST_Area(ST_Intersection(g.geom, c.geom)) / ST_Area(g.geom)) * 100 
                ELSE 0 
            END
        ), 100), 0
    ) AS remaining_percentage
FROM "public"."dkn_10km_etrs89" AS g
LEFT JOIN "public"."CORINE" AS c
ON ST_Intersects(g.geom, c.geom)
GROUP BY g.id
)

-- Combine results into final grid with flags and class breakdowns
SELECT 
  g.*,
  lakes.contains_lake,
  COALESCE(no_overlap.no_overlap, 0) AS no_overlap,
  COALESCE(partial_overlap.partial_overlap, 0) AS partial_overlap,
  cb.class_1_percentage,
  cb.class_2_percentage,
  cb.class_3_percentage,
  cb.class_4_percentage,
  cb.class_5_percentage,
  cb.class_6_percentage,
  cb.class_7_percentage,
  cb.class_8_percentage,
  cb.class_9_percentage,
  cb.class_10_percentage,
  cb.class_11_percentage,
  cb.class_12_percentage,
  cb.class_16_percentage,
  cb.class_18_percentage,
  cb.class_20_percentage,
  cb.class_21_percentage,
  cb.class_23_percentage,
  cb.class_24_percentage,
  cb.class_25_percentage,
  cb.class_26_percentage,
  cb.class_27_percentage,
  cb.class_29_percentage,
  cb.class_30_percentage,
  cb.class_33_percentage,
  cb.class_35_percentage,
  cb.class_36_percentage,
  cb.class_37_percentage,
  cb.class_39_percentage,
  cb.class_41_percentage,
  cb.class_42_percentage,
  cb.class_44_percentage,
  cb.total_percentage AS total_class_coverage,
  cb.remaining_percentage AS unclassified_percentage
FROM "public"."dkn_10km_etrs89" AS g
LEFT JOIN grid_with_lakes AS lakes ON lakes.id = g.id
LEFT JOIN grid_no_overlap AS no_overlap ON no_overlap.id = g.id
LEFT JOIN grid_partial_overlap AS partial_overlap ON partial_overlap.id = g.id
JOIN class_breakdown AS cb ON g.id = cb.id
ORDER BY g.id;
