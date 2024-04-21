require_relative '../lib/haste'

Haste.demo { label('Downloading').bar.percent }
Haste.demo { spinner.label('Uploading').fraction.timed.spinner }
Haste.demo { label('Shutting down').spinner(frames: ['.  ', '.. ', '...'], speed: 0.1).percent }

class ExampleView
  def print(progress)
    "Progress: #{progress}"
  end
end

Haste.add_views do |registry|
  registry.add(:from_class, handler: ExampleView)
  registry.add(:from_block) do |progress|
    "Eventually we'll hit #{progress.goal}, #{progress.remaining} to go"
  end
end

Haste.demo { label('From class:').from_class }
Haste.demo { label('From block:').from_block }
