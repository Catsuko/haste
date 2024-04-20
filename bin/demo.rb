require_relative '../lib/haste'

Haste.demo { label('Downloading').bar.percent }
Haste.demo { spinner.label('Uploading').fraction.timed.spinner }
Haste.demo { label('Shutting down').spinner(frames: ['.  ', '.. ', '...'], speed: 0.1).percent }
