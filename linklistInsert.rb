require 'pry'
class Node
	attr_accessor :data,:link
		def initialize(data)
			self.data=data
			self.link=nil
			
		end
end
class LinkedList
	#constructor to initialize head
	attr_accessor :data,:link,:head
	def initialize()
		self.head=nil
	end

	def insertAtBeg(data)
		new_node=Node.new(data)
		#Now this node becomes the first node
		new_node.link=head
		self.head=new_node
		
	end
	def insertAtEnd(data)
		if self.head.nil?
			puts "Empty list!!"
			return 0
		else
			new_node=Node.new(data)
			new_node.link=nil
			#Now try to iterate through all the link list and reach the end
			prev_node=self.head
			until prev_node.nil? do
				temp=prev_node
				prev_node=prev_node.link

			end
			temp.link=new_node
        end
	end
	def insertAtPos(prev_node,data)
		new_node=Node.new(data)
		if prev_node.nil?
			puts "Previous node can't be null"
		end
		if self.head.nil?
			puts "No element !"
			return 0
		else
		  	new_node.link=prev_node.link
		  	prev_node.link=new_node
		end
	end
	def printList()
		 tnode=self.head
		 puts ".....Printing list ......"
		 until tnode.nil? do
		
			 print "#{tnode.data}"+"-->"
             tnode=tnode.link
             
		end
	end
end


#call all the methods

list=LinkedList.new()
list.insertAtBeg(1)
list.insertAtBeg(2)
list.insertAtBeg(3)
list.insertAtEnd(78)
list.insertAtPos(list.head.link,8)
list.printList