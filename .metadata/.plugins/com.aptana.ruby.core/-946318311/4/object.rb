class Object < BasicObject
  include Kernel

  ARGF = ARGF
  ARGV = []
  ArgumentError = ArgumentError
  Array = Array
  BasicObject = BasicObject
  Bignum = Bignum
  Binding = Binding
  CROSS_COMPILING = nil
  Class = Class
  Comparable = Comparable
  Complex = Complex
  Config = RbConfig
  Data = Data
  Date = Date
  DateTime = DateTime
  Dir = Dir
  ENV = {"MDMSESSION"=>"cinnamon", "GNOME_KEYRING_CONTROL"=>"/run/user/1000/keyring-YCsCCI", "SSH_AGENT_PID"=>"2044", "TEXTDOMAINDIR"=>"/usr/share/locale/", "GDM_XSERVER_LOCATION"=>"local", "SESSION_MANAGER"=>"local/brezina-MintOS:@/tmp/.ICE-unix/1908,unix/brezina-MintOS:/tmp/.ICE-unix/1908", "GNOME_DESKTOP_SESSION_ID"=>"this-is-deprecated", "GDMSESSION"=>"cinnamon", "XDG_SESSION_COOKIE"=>"8b15c50022db2b4bb4f41276567433e8-1451140535.650875-1007534050", "XDG_DATA_DIRS"=>"/usr/share/cinnamon:/usr/share/gnome:/usr/local/share/:/usr/share/:/usr/share/mdm/", "MANDATORY_PATH"=>"/usr/share/gconf/cinnamon.mandatory.path", "PWD"=>"/home/brezina", "GIO_LAUNCHED_DESKTOP_FILE"=>"/usr/share/applications/eclipse.desktop", "MDM_XSERVER_LOCATION"=>"local", "LOGNAME"=>"brezina", "GPG_AGENT_INFO"=>"/run/user/1000/keyring-YCsCCI/gpg:0:1", "GIO_LAUNCHED_DESKTOP_FILE_PID"=>"4566", "GJS_DEBUG_TOPICS"=>"JS ERROR;JS LOG", "SSH_AUTH_SOCK"=>"/run/user/1000/keyring-YCsCCI/ssh", "TEXTDOMAIN"=>"im-config", "SHELL"=>"/bin/bash", "CLUTTER_BACKEND"=>"x11", "DBUS_SESSION_BUS_ADDRESS"=>"unix:abstract=/tmp/dbus-UgGExjdbL8,guid=d4cb98ad9adbb70d32db63f3567ea5b8", "XDG_CONFIG_DIRS"=>"/etc/xdg/xdg-cinnamon:/etc/xdg", "XDG_CURRENT_DESKTOP"=>"X-Cinnamon", "PATH"=>"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games", "CINNAMON_VERSION"=>"2.6.13", "DESKTOP_SESSION"=>"cinnamon", "DISPLAY"=>":0", "USER"=>"brezina", "GJS_DEBUG_OUTPUT"=>"stderr", "HOME"=>"/home/brezina", "XAUTHORITY"=>"/home/brezina/.Xauthority", "XDG_SEAT"=>"seat0", "WINDOWPATH"=>"8", "XDG_SESSION_ID"=>"c2", "DEFAULTS_PATH"=>"/usr/share/gconf/cinnamon.default.path", "USERNAME"=>"brezina", "MDM_LANG"=>"cs_CZ.UTF-8", "XDG_VTNR"=>"8", "XDG_SESSION_DESKTOP"=>"cinnamon", "XDG_RUNTIME_DIR"=>"/run/user/1000", "LANG"=>"cs_CZ.UTF-8"}
  EOFError = EOFError
  Encoding = Encoding
  EncodingError = EncodingError
  Enumerable = Enumerable
  Enumerator = Enumerator
  Errno = Errno
  Etc = Etc
  Exception = Exception
  FALSE = false
  FalseClass = FalseClass
  Fiber = Fiber
  FiberError = FiberError
  File = File
  FileTest = FileTest
  FileUtils = FileUtils
  Fixnum = Fixnum
  Float = Float
  FloatDomainError = FloatDomainError
  GC = GC
  Gem = Gem
  Hash = Hash
  IO = IO
  IOError = IOError
  IndexError = IndexError
  Integer = Integer
  Interrupt = Interrupt
  Kernel = Kernel
  KeyError = KeyError
  LoadError = LoadError
  LocalJumpError = LocalJumpError
  Marshal = Marshal
  MatchData = MatchData
  Math = Math
  Method = Method
  Module = Module
  Mutex = Mutex
  NIL = nil
  NameError = NameError
  NilClass = NilClass
  NoMemoryError = NoMemoryError
  NoMethodError = NoMethodError
  NotImplementedError = NotImplementedError
  Numeric = Numeric
  OUTPUT_PATH = "/home/brezina/skola/zapoctak/.metadata/.plugins/com.aptana.ruby.core/-946318311/4/"
  Object = Object
  ObjectSpace = ObjectSpace
  Proc = Proc
  Process = Process
  Psych = Psych
  RUBY_COPYRIGHT = "ruby - Copyright (C) 1993-2013 Yukihiro Matsumoto"
  RUBY_DESCRIPTION = "ruby 1.9.3p484 (2013-11-22 revision 43786) [x86_64-linux]"
  RUBY_ENGINE = "ruby"
  RUBY_PATCHLEVEL = 484
  RUBY_PLATFORM = "x86_64-linux"
  RUBY_RELEASE_DATE = "2013-11-22"
  RUBY_REVISION = 43786
  RUBY_VERSION = "1.9.3"
  Random = Random
  Range = Range
  RangeError = RangeError
  Rational = Rational
  RbConfig = RbConfig
  Regexp = Regexp
  RegexpError = RegexpError
  RubyVM = RubyVM
  RuntimeError = RuntimeError
  STDERR = IO.new
  STDIN = IO.new
  STDOUT = IO.new
  ScanError = StringScanner::Error
  ScriptError = ScriptError
  SecurityError = SecurityError
  Signal = Signal
  SignalException = SignalException
  StandardError = StandardError
  StopIteration = StopIteration
  String = String
  StringIO = StringIO
  StringScanner = StringScanner
  Struct = Struct
  Syck = Syck
  Symbol = Symbol
  SyntaxError = SyntaxError
  SystemCallError = SystemCallError
  SystemExit = SystemExit
  SystemStackError = SystemStackError
  TOPLEVEL_BINDING = #<Binding:0x00000000dd3fd8>
  TRUE = true
  TSort = TSort
  Thread = Thread
  ThreadError = ThreadError
  ThreadGroup = ThreadGroup
  Time = Time
  TrueClass = TrueClass
  TypeError = TypeError
  URI = URI
  UnboundMethod = UnboundMethod
  YAML = Psych
  ZeroDivisionError = ZeroDivisionError
  Zlib = Zlib

  def self.yaml_tag(arg0)
  end


  def psych_to_yaml(arg0, arg1, *rest)
  end

  def to_yaml(arg0, arg1, *rest)
  end

  def to_yaml_properties
  end


  protected


  private

  def dir_names(arg0)
  end

  def file_name(arg0)
  end

  def get_classes
  end

  def grab_instance_method(arg0, arg1)
  end

  def print_args(arg0)
  end

  def print_instance_method(arg0, arg1)
  end

  def print_method(arg0, arg1, arg2, arg3, arg4, *rest)
  end

  def print_type(arg0)
  end

  def print_value(arg0)
  end

end
