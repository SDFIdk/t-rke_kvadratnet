WITH bbox AS (
SELECT ST_SetSRID(ST_Extent(geom), 25832) as bbox_coords
FROM "public"."10km_classified_grid" 
WHERE no_overlap = 0
)

SELECT 
id,
    geom,
	contains_lake,
	no_overlap,
	partial_overlap,
    (
	class_1_percentage + 
	class_2_percentage + 
	class_3_percentage + 
	class_4_percentage + 
	class_5_percentage +
	class_6_percentage + 
	class_7_percentage + 
	class_8_percentage + 
	class_9_percentage + 
	class_10_percentage + 
	class_11_percentage
	) AS urban,
	(
	class_23_percentage + 
	class_24_percentage + 
	class_25_percentage + 
	class_29_percentage
	) AS forest, 
    (
	class_12_percentage + 
	class_16_percentage
	) AS agriculture,
	(
	class_18_percentage + 
	class_20_percentage + 
	class_21_percentage + 
	class_26_percentage + 
	class_27_percentage +
	class_30_percentage + 
	class_33_percentage + 
	class_35_percentage + 
	class_36_percentage + 
	class_37_percentage + 
	class_39_percentage
	) AS nature,
	(
	class_41_percentage + 
	class_42_percentage + 
	class_44_percentage
	) AS water
FROM "public"."10km_classified_grid"
WHERE ST_Intersects(geom, (SELECT bbox_coords FROM bbox));
