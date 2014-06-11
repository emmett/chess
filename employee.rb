class Employee
  attr_accessor :boss, :employees, :salary
  
  def initialize (name, salary, title, boss = nil)
    @name, @salary, @title, @boss = name, salary, title, 
        boss
        @employees = []
    @boss.employees << self if boss
  end
  
  def bonus(mult)
    bonus = @salary * mult
  end
end

class Manager < Employee
  def initialize(name, salary, title, boss = nil)
    super(name, salary, title, boss)
  end    
  
  def add_underling(employee)
    self.employees << employee
    employee.boss = self
  end
  
  def bonus(mult)
    bonus = 0
    employees.each do |employee| 
      if employee.employees.empty?
        bonus += employee.salary
      else 
        bonus += employee.bonus(1) + employee.salary
      end
    end
    return bonus * mult
  end
end