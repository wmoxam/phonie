require 'yaml'
# support methods to remove dependencies on ActiveSupport

module Accessorize
  module ClassMethods
    def cattr_accessor(*syms)
      syms.flatten.each do |sym|
        class_eval(<<-EOS, __FILE__, __LINE__)
          unless defined? @@#{sym}
            @@#{sym} = nil
          end

          def self.#{sym}
            @@#{sym}
          end

          def #{sym}=(value)
            @@#{sym} = value
          end

          def self.#{sym}=(value)
            @@#{sym} = value
          end

          def #{sym}
            @@#{sym}
          end
        EOS
      end
    end    
  end


  def self.included(receiver)
    receiver.extend         ClassMethods
  end
end

Object.send(:include, Accessorize)
