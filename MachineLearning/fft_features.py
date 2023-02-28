import numpy as np


# expecting np.array data, and time window, window
def ff_features(data, window):
	n = data.size

	#compute the fft
	fft = np.fft.rfft(data)

	#find the freqs
	freqs = np.fft.rfftfreq(n,d = 1./window)

	max_mag = 0
	max_mag_freq = 0
	mag_avg = 0
	mag_sum = 0

	for i in range(len(fft)):
		mag = np.absolute(fft[i])
		mag_sum += mag     #sum the magnitudes
		if mag > max_mag:
			max_mag = mag  #set the maximum value
			max_index = i  #set the index of maximum value

	mag_avg = mag_sum/len(fft)       # find the average magnitude
	max_mag_freq = freqs[max_index]  # find the frequency where the max occured

	return [max_mag_freq, max_mag, mag_avg] #return array of wanted values [maximum magnitude, ma]


# the data we are using is over the time window being given by w.  This means that if we wanted, i think this can be used with the hourly data, i.e.,
# the input array can have more data points than the timeframe window.  We can have 100 datapoints that would be spaced out evenly over the window, w.
# to use the outputs, set a dummy variable x = ff_features(data, window), then set x[0], x[1], x[3] into new columns


		

