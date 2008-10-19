require File.expand_path("spec_helper", File.dirname(__FILE__))

describe Kernel, ".__DIR__" do
	it { __DIR__.should == File.expand_path(File.dirname(__FILE__)) }
end
