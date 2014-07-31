load 'gnuplot.rb'

def constant_time(n)
	start = Time.now
	output=n*n*n
	finish = Time.now
	return (finish-start)*1000
end

def linear_time(n)
	start = Time.now
	for i in 0..n
		output=i
	end
	finish = Time.now
	return (finish-start)*1000
end

def log_time(n)
	start = Time.now
	i=1
	while i<n
		i=i*2
	end
	finish = Time.now
	return (finish-start)*1000
end	

def square_time(n)
	start = Time.now
	for i in 0..n
		for j in 0..n
			output=i
		end
	end
	finish = Time.now
	return (finish-start)*1000
end


def plot(dataset,title)

Gnuplot.open do |gp|
  Gnuplot::Plot.new( gp ) do |plot|
  
	filename=title+'.png'
	plot.output filename
	plot.terminal 'png'

	plot.yrange "[0:0.1]"  #Change range of y-axis here if your runnning time is above 0.1ms
    plot.title  title
    plot.ylabel 'Running time in millisecond'
    plot.xlabel "n"
    
    x = dataset.keys
    y = dataset.values

    plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|
      ds.with = "linespoints"
      ds.notitle
    end
  end
end


end



puts 'Please make sure you have GNUPlot installed. Run "brew install gnuplot" for Mac, you should have GNUPlot installed already if you are using Ubuntu'

o1={}
on={}
ologn={}
on2={}


#Change n if you want
for n in 0..1000
	o1[n]=constant_time(n)
	on[n]=linear_time(n)
	ologn[n]=log_time(n)
	on2[n]=square_time(n)
end


plot(o1,'Constant Time')
plot(on,'Linear Time')
plot(ologn,'Log Time')
plot(on2,'Square Time')






