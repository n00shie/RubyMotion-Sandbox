class ColourController < UIViewController
  attr_accessor :color

  def initWithColor(color)
    initWithNibName(nil, bundle:nil)
    self.color = color
    self
  end

  def viewDidLoad
    super
    self.title = self.color.hex

    @info_container = UIView.alloc.initWithFrame [[0,0], [self.view.frame.size.width, 110]]
    @info_container.backgroundColor = UIColor.lightGrayColor
    self.view.addSubview @info_container

    @color_view = UIView.alloc.initWithFrame [[10,10], [90,90]]
    @color_view.backgroundColor = String.new(self.color.hex).to_color
    self.view.addSubview @color_view

    @color_label = UILabel.alloc.initWithFrame [[110,30],[0,0]]
    @color_label.text = self.color.hex
    @color_label.sizeToFit
    self.view.addSubview @color_label

    @text_field = UITextField.alloc.initWithFrame [[110, 60], [100, 26]]
    @text_field.placeholder = "tag"
    @text_field.textAlignment = UITextAlignmentCenter
    @text_field.autocapitalizationType = UITextAutocapitalizationTypeNone
    @text_field.borderStyle = UITextBorderStyleRoundedRect
    self.view.addSubview @text_field

    @add = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @add.setTitle("Add", forState:UIControlStateNormal)
    @add.setTitle("Adding...", forState:UIControlStateDisabled)
    @add.setTitleColor(UIColor.lightGrayColor, forState:UIControlStateDisabled)
    @add.sizeToFit
    @add.frame = [[@text_field.frame.origin.x + @text_field.frame.size.width + 10, @text_field.frame.origin.y], @add.frame.size]
    self.view.addSubview(@add)

    table_frame = [[0, @info_container.frame.size.height],
                  [self.view.bounds.size.width, self.view.bounds.size.height - @info_container.frame.size.height - self.navigationController.navigationBar.frame.size.height]]
    @table_view = UITableView.alloc.initWithFrame(table_frame, style:UITableViewStylePlain)
    self.view.addSubview(@table_view)

    @table_view.dataSource = self
  end

  def tableView(tableView, numberOfRowsInSection:section)
    self.color.tags.count
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    cell.textLabel.text = self.color.tags[indexPath.row].name

    cell
  end


end
