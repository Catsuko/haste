# haste

Quick progress visualization to make your CLI and script loading look cool!

## Installation

Add the gem to your Gemfile:
```ruby
gem 'haste', git: 'https://github.com/Catsuko/haste'
```

## Usage

```ruby
require 'haste

progress_bar = Haste.label('Downloading').bar.percent.build(goal: 100)

100.times do |n|
  progress_bar.update(n)
  sleep(0.1)
end

# => Downloading |██████████████████████████████████████████████████| 100%
```

For some examples in your terminal, run the `bin/demo.rb` script.

### Tracking Progress

Once you have built a progress element, track progress towards the goal with either the `#update` or `#increase` method:
- `#update` will set the progress amount to the provided value
- `#increase` will add the provided value to the current progress

### Rendering the bar

At any point, the bar can be rendered by calling the `#to_s` method. There is also a `#print` method which will render the bar and write to `STDOUT` by default.

### Changing Appearance

The appearance of the progress bar is determined by the calls prior to `#build`. The call order will determine the order of elements and the methods called will determine the types of elements to add. Here is an example:

```ruby
Haste.label('Downloading').build(goal: 100).print
# => Downloading
Haste.label('Downloading').bar.build(goal: 100).print
# => Downloading |                                          |
Haste.bar.percentage.build(:goal: 100).print
# => |                                          | 0%
```

Below is a list of the types of elements and the options they support:

**label**

Adds a text element to the progress bar.

**percent**

Adds a label displaying the percentage completed.

**fraction**

Adds a label displaying the current progress and goal as a fraction, for example: `32/100`.

**bar**

Adds a large bar that fills up to make the progress completed. The following options can be provided to change how it looks:
- length - size of the bar
- border - character to use for the edges of the bar
- fill - character to use when filling the bar
- empty - character to use for the empty portion of the bar

**spinner**

Adds an animated label that cycles through frames periodically. By default it resembles a spinning circle:

```ruby
# Create a spinning icon
Haste.spinner.build(goal: 100).print
# Change the speed, lets go faster!
Haste.spinner(speed: 0.75).build(goal: 100).print
# Change the frames:
Haste.spinner(frames: ['.  ', '.. ', '...']).build(goal: 100).print
```

**timed**

Provides a label that after a short delay, showing the estimated time remaining.
