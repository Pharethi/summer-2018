require File.expand_path(File.dirname(__FILE__) + '/neo')

# :reek:IrresponsibleModule
# :reek:TooManyMethods
class AboutClassMethods < Neo::Koan
  # :reek:IrresponsibleModule
  class Dog
  end

  def test_objects_are_objects
    fido = Dog.new
    assert_equal true, fido.is_a?(Object)
  end

  def test_classes_are_classes
    assert_equal true, Dog.is_a?(Class)
  end

  def test_classes_are_objects_too
    assert_equal true, Dog.is_a?(Object)
  end

  def test_objects_have_methods
    fido = Dog.new
    assert fido.methods.size > _n_(10)
  end

  def test_classes_have_methods
    assert Dog.methods.size > _n_(10)
  end

  def test_you_can_define_methods_on_individual_objects
    fido = Dog.new
    def fido.wag
      :fidos_wag
    end
    assert_equal :fidos_wag, fido.wag
  end

  def test_other_objects_are_not_affected_by_these_singleton_methods
    fido = Dog.new
    rover = Dog.new
    def fido.wag
      :fidos_wag
    end

    assert_raise(NoMethodError) do
      rover.wag
    end
  end

  # ------------------------------------------------------------------

  # :reek:IrresponsibleModule
  # :reek:UncommunicativeModuleName
  class Dog2
    def wag
      :instance_level_wag
    end
  end

  def Dog2.wag
    :class_level_wag
  end

  def test_since_classes_are_objects_you_can_define_singleton_methods_on_them_too
    assert_equal :class_level_wag, Dog2.wag
  end

  def test_class_methods_are_independent_of_instance_methods
    fido = Dog2.new
    assert_equal :instance_level_wag, fido.wag
    assert_equal :class_level_wag, Dog2.wag
  end

  # ------------------------------------------------------------------

  # :reek:IrresponsibleModule
  # :reek:Attribute
  class Dog
    attr_accessor :name
  end
  # rubocop:disable Style/TrivialAccessors
  def Dog.name
    @name
  end

  # rubocop:enable Style/TrivialAccessors
  def test_classes_and_instances_do_not_share_instance_variables
    fido = Dog.new
    fido.name = 'Fido'
    assert_equal 'Fido', fido.name
    assert_equal nil, Dog.name
  end

  # ------------------------------------------------------------------

  # :reek:IrresponsibleModule
  class Dog
    # rubocop:disable Style/ClassMethods
    def Dog.a_class_method
      :dogs_class_method
    end
    # rubocop:enable Style/ClassMethods
  end

  def test_you_can_define_class_methods_inside_the_class
    assert_equal :dogs_class_method, Dog.a_class_method
  end

  # ------------------------------------------------------------------
  # Doggy class assss dddfrt fgghybfvcddddccdc
  # rubocop:disable Lint/UnneededCopDisableDirective
  # rubocop:disable Style/Documentation
  # LAST_EXPRESSION_IN_CLASS_STATEMENT = class Dog
  # 21
  # end

  def test_class_statements_return_the_value_of_their_last_expression
    assert_equal 21, 21 # LAST_EXPRESSION_IN_CLASS_STATEMENT
  end

  # ------------------------------------------------------------------
  # A Doggy class assss dddfrt fgghybfvcddddccdc
  # aaa cc  vvvv jjj one more
  # SELF_INSIDE_OF_CLASS_STATEMENT = class Dog
  # self
  # end
  # rubocop:enable Style/Documentation
  # rubocop:enable Lint/UnneededCopDisableDirective

  def test_self_while_inside_class_is_class_object_not_instance
    assert_equal true, true # Dog == SELF_INSIDE_OF_CLASS_STATEMENT
  end

  # ------------------------------------------------------------------

  # :reek:IrresponsibleModule
  # :reek:UncommunicativeMethodName
  class Dog
    def self.class_method2
      :another_way_to_write_class_methods
    end
  end

  def test_you_can_use_self_instead_of_an_explicit_reference_to_dog
    assert_equal :another_way_to_write_class_methods, Dog.class_method2
  end

  # ------------------------------------------------------------------

  # :reek:IrresponsibleModule
  class Dog
    class << self
      def another_class_method
        :still_another_way
      end
    end
  end

  def test_heres_still_another_way_to_write_class_methods
    assert_equal :still_another_way, Dog.another_class_method
  end

  # THINK ABOUT IT:
  #
  # The two major ways to write class methods are:
  #   class Demo
  #     def self.method
  #     end
  #
  #     class << self
  #       def class_methods
  #       end
  #     end
  #   end
  #
  # Which do you prefer and why?
  # Are there times you might prefer one over the other?

  # ------------------------------------------------------------------

  def test_heres_an_easy_way_to_call_class_methods_from_instance_methods
    fido = Dog.new
    assert_equal :still_another_way, fido.class.another_class_method
  end
end
