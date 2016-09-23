noflo = require 'noflo'
clipsy = require 'clipsy'

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Encapsulates the process of offsetting (inflating/deflating) both open and closed paths.'
  c.icon = 'camera'

  # c.inPorts.add 'paths',
  #   datatype: 'all'
  #   description: 'Paths to offset'

  c.inPorts.add 'delta',
    datatype: 'number'
    description: 'Amount to offset by'

  c.inPorts.add 'jointype',
    datatype: 'int'
    description: 'Style of join to use'

  c.inPorts.add 'miterlimit',
    datatype: 'number'
    description: 'Miter limit'

  c.outPorts.add 'out',
    datatype: 'all'

  noflo.helpers.WirePattern c,
    in: ['delta', 'jointype', 'miterlimit']
    out: 'out'
    forwardGroups: true
    async: false
  , (data, groups, out, callback) ->

    paths = [[{X:-85.5,Y:33.2},{X:-85.5,Y:33.3},{X:-85.4,Y:33.3},{X:-85.4,Y:33.2}]]

    clipper = new clipsy.Clipper()
    new_path = clipper.OffsetPolygons(paths, data.delta, data.jointype, data.miterlimit, true)[0]

    # do something with data
    # send it on outport
    out.send data

    # let WirePattern know we are done
    # do callback
  c

