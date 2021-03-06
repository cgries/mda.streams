#'@title post timeseries data for all sites for a given variable
#'@description post timeseries data for all sites for a given variable. 
#'Will create new item or skip if it already exists

#'@param variable shortname for the variable
#'@param p_code a string for a valid NWIS parameter code
#'@param startDate a string in the form of YYYY-MM-DD
#'@param session a valid authenticated sciencebase session
#'
#'@import sbtools
#'@seealso \code{\link{post_ts}}
#'@examples
#'\dontrun{
#'post_nwis_ts(variable = 'wtr', p_code='00010', session, startDate = '2008-01-01')
#'}
#'@export
post_nwis_ts = function(variable, p_code, session, startDate = '2008-01-01'){
  sites <- get_sites()
  session <- authenticate_sb(username)
  
  type = paste('ts',variable,sep='_')
  for (i in 1:length(sites)){
    site <- sites[i]
    exists <- item_exists(scheme = 'mda_streams', type, key = site, session)
    if (!exists){
      df <- get_nwis_df(site, variable_name = variable, p_code, startDate = '2008-01-01')
      Sys.sleep(10)
      post_ts(site = site, data = df, variable = variable, session = session)
      cat('done with ')
      cat(site)
      cat('\n')
    } else {
      cat('skipping ')
      cat(site)
      cat('\n')
    }
    
  }
}

