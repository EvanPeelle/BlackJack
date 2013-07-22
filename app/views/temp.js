head = 5
head.next = {6}
head.next.next = 7
head.next.next.next = 8

next  = linkedList.head.next; // next = head.next = {6}
linkedList.head.next = linkedList.head; // 
linkedList.head = next;