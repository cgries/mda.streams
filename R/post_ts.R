#'
#'@title Post a new timeseries file to SB
#'
#'
#'@param site Unique site ID
#'@param data A data.frame containing the timeseries
#'@param variable Timeseries identifiying string eg [ts_stage, ts_doobs, ts_wtr, etc]
#'@param session Session object from \link{authenticate_sb}
#'
#'@author Luke Winslow, Corinna Gries
#'
#'
#'@import sbtools
#'
#'@export
post_ts = function(site, data, variable, session){
	
	
	#check input
	## TODO: check input and format of DATA
	
	#save data as a file
	
	fpath = tempfile(fileext = '.tsv')
	
	write.table(data, fpath, sep='\t', row.names=FALSE)
	
	
	#Check if item already exists
	item = query_item_identifier(scheme='mda_streams',type=variable, 
															 key=site, session=session)
	
	if(nrow(item) > 0){
		stop('This Timeseries for this site already exists')
	}	
	
	#find site root
	site_root = query_item_identifier(scheme='mda_streams', 
																		type='site_root', key=site, session=session)
	if(nrow(site_root) != 1){
		stop('There is no site root available for site:', site)
	}
	
	#Create item if it does not exist
	ts_item = item_create(parent_id=site_root$id, 
												title=variable, session=session)
	
	#tag item with our special identifier
	item_update_identifier(ts_item, scheme='mda_streams', type=variable, 
												 key=site, session=session)
	
	#attach file to item
	item_append_file(ts_item, filename=fpath, session=session)
	
	return(ts_item)
}