class Transfer
  attr_accessor :amount, :status
  attr_reader :sender, :receiver
@@transfers = []

  def initialize(sender, receiver, amount)
    @status = "pending"
    @sender = sender
    @receiver = receiver
    @amount = amount

  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if !@@transfers.include?(self) && self.valid? && @sender.balance > @amount
      @receiver.deposit(amount)
      @sender.pay(amount)
      @@transfers << self
      @status = "complete"
  elsif
    @status = "rejected"
    "Transaction rejected. Please check your account balance."
  end
  end

  def reverse_transfer
    if @@transfers.include?(self)
      @sender.deposit(amount)
      @receiver.pay(amount)
      @status = "reversed"
    end
  end
end
