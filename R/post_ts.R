#'
#'@title Post a new timeseries file to SB
#'
#'
#'@param site Unique site ID
#'@param data A data.frame containing the timeseries
#'@param variable Timeseries identifiying string variable eg [stage, doobs, wtr, etc]
#'@param session Session object from \link{authenticate_sb}
#'
#'@author Luke Winslow, Corinna Gries
#'
#'
#'@import sbtools
#'
#'@export
post_ts = function(site, data, variable, session){
	
	
  ts_varname <- paste('ts', variable, sep = '_')
	#check input
	## TODO: check input and format of DATA
	
	#save data as a file
	
	fpath = tempfile(fileext = '.tsv.gz')
	
  gz1 <- gzfile(fpath, "w")
	write.table(data,  gz1, sep='\t', row.names=FALSE, quote = FALSE)
  close(gz1)
	
	#Check if item already exists
  if(item_exists(scheme='mda_streams',type=ts_varname, 
															 key=site, session=session)){
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
												title=ts_varname, session=session)
	
  #attach file to item
  item_append_file(ts_item, filename=fpath, session=session)
  
	#tag item with our special identifier
	item_update_identifier(ts_item, scheme='mda_streams', type=ts_varname, 
												 key=site, session=session)
	
	
	
	return(ts_item)
}