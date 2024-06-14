This repo contains a version of the danish square grid (kvadratnet), with each grid containing information on land polygon overlap 
and percantage wise components of overlapping classes based on the EUs CORINE LCLU map of 2018.
The classified grids are available in 1 and 10 kilometer sizes (gpkg files zipped in 1km_classified_grid.7z, 10km_classified_grid.7z).

In addition, the repo contains SQL file which can produce the maps from the base components, the standard square grid in 1 and 10 kilometers, 
a CORINE map of Danmark and the Danish land polygon, all of which lie in the "base_components" folder.

Tile data contents:

	Flags:
		Contains lake [boolean]: Tile overlaps a lake larger than 10.000m2
		No overlap [boolean]: Tile does not overlap land polygon
		Partial overlap [boolean]: Tile has partial overlap with land polygon
	
	Classes:
		All included classes are represented on each tile as the percentage they make upcwithin the tile. 
		Classes which are not included in the table do not occour in Denmark on CORINEs maps.
	
	Total class overlap: Percent of the tile with CORINE overlap
		Unclassified percentage: Percent of the tile without CORINE overlap.