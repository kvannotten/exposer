# Exposer [![Build Status](https://travis-ci.org/kvannotten/exposer.png?branch=master)](https://travis-ci.org/kvannotten/exposer)

Exposer exposes your services to the internet via a combination of smart ssh remote port forwarding and reverse nginx proxying. 

What this means is that you can just spawn a service, tell exposer what port it runs on, on your local machine, and Exposer will
give you an URL where your service will be accessible for the entire internet to see (or at least those who know the URL)

## Installation

Install exposer:

    $ gem install exposer

## Usage

After you have installed exposer you can simply start it as follows:

    $ exposer -p <PORT>
    
Where <PORT> is the port you wish to expose. For example, if you are 
creating a ruby web application, and you do a rackup, which starts a webservice at
port 9292, then you would do:

    $ exposer -p 9292
    
You would get a response that is similar to the following:

```
Starting connection...
You can reach your service on http://yo9q.exposer.io

Press CTRL+C to stop the connection.
```

You can then just share the link that is given to you in the response. And via that link people can reach
the application that you just have set up! It's almost magic!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
