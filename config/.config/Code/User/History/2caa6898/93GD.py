from __future__ import annotations
from typing import TypeVar, Iterable, Sequence, Generic, List, Callable, Set, Deque, Dict, Any, Optional, Protocol
from heapq import heappush, heappop

T = TypeVar('T')


def linear_contains(iterable: Iterable[T], key: T) -> bool:
    for item in iterable:
        if item == key:
            return True
    return False


C = TypeVar("C", bound="Comparable")


class Comparable(Protocol):
    def __eq__(self, other: Any) -> bool:
        ...

    def __lt__(self: C, other: C) -> bool:
        ...

    def __gt__(self: C, other: C) -> bool:
        return (not self < other) and self != other

    def __le__(self: C, other: C) -> bool:
        return self < other or self == other

    def __ge__(self: C, other: C) -> bool:
        return not self < other


def binary_contains(sequence: Sequence[C], key: C) -> bool:
    low: int = 0
    high: int = len(sequence) - 1
    while low <= high:  # while there is still a search space
        mid: int = (low + high) // 2
        if sequence[mid] < key:
            low = mid + 1
        elif sequence[mid] > key:
            high = mid - 1
        else:
            return True
    return False


class Stack(Generic[T]):
    def __init__(self) -> None:
        self._container: List[T] = []
    
    @property
    def empty(self) -> bool:
        return not self._container
    
    def push(self, item: T) -> None:
        self._container.append(item)
    
    def pop(self) -> T:
        return self._container.pop() #LIFO

    def __repr__(self) -> str:
        return repr(self._container)
    

class Node(Generic[T]):
    def __init__(self, state: T, parent: Optional[Node], cost: float = 0.0, heuristic: float = 0.0) -> None:
        self.state: T = state
        self.parent: Optional[Node] = parent
        self.cost: float = cost
        self.heuristc: float = heuristic
    
    def __lt__(self, other: Node) -> bool:
        return (self.cost + self.heuristc) < (other.cost + other.heuristc)


def dfs(initial: T, goal_test: Callable[[T], bool], sucessors: Callable[[T], List[T]]) -> Optional[Node[T]]:
    # frontier corresponde aos lugares que ainda nao visitamos
    frontier: Stack[Node[T]] = Stack()
    frontier.push(Node(initial, None))
    # explored representa os lugares em que já estivemos
    explored: Set[T] = {initial}

    # continua enquanto houver mais lugares para explorar
    while not frontier.empty:
        current_node: Node[T] = frontier.pop()
        current_state: T = current_node.state
        # se encontrarmos o objetivo, terminamos
        if goal_test(current_state):
            return current_node
        # verifica para onde podemos ir em seguida e que ainda não tenha sido explorado
        for child in sucessors(current_state):
            if child in explored: # ignora os filhos que ja tenham sido explorados
                continue
            explored.add(child)
            frontier.push(Node(child, current_node))
    return None # passamos por todos os lugares e nao atingimos o objetivo


def node_to_path(node: Node[T]) -> List[T]:
    path: List[T] = [node.state]
    # trabalha o sentido inverso, do final para o inicio
    while node.parent is not None:
        node = node.parent
        path.append(node.state)
    path.reverse()
    return path


class Queue(Generic[T]):
    def __init__(self) -> None:
        self._container: Deque[T] = Deque()
    
    @property
    def empty(self) -> bool:
        return not self._container # negação é verdadeira para um container vazio
    
    def push(self, item: T) -> None:
        self._container.append(item)
    
    def pop(self) -> T:
        return self._container.popleft() #FIFO

    def __repr__(self) -> str:
        return repr(self._container)
 

def bfs(initial: T, goal_test: Callable[[T], bool], sucessors: Callable[[T], List[T]]) -> Optional[Node[T]]:
    # frontier corresponde aos lugares que ainda nao visitamos
    frontier: Queue[Node[T]] = Queue()
    frontier.push(Node(initial, None))
    # explored representa os lugares em que já estivemos
    explored: Set[T] = {initial}

    # continua enquanto houver mais lugares para explorar
    while not frontier.empty:
        current_node: Node[T] = frontier.pop()
        current_state: T = current_node.state
        # se encontrarmos o objetivo, terminamos
        if goal_test(current_state):
            return current_node
        # verifica para onde podemos ir em seguida e que ainda não tenha sido explorado
        for child in sucessors(current_state):
            if child in explored: # ignora os filhos que ja tenham sido explorados
                continue
            explored.add(child)
            frontier.push(Node(child, current_node))
    return None # passamos por todos os lugares e nao atingimos o objetivo


class PriorityQueue(Generic[T]):
    def __init__(self) -> None:
        self._container: Deque[T] = Deque()
    
    @property
    def empty(self) -> bool:
        return not self._container # negação é verdadeira para um container vazio
    
    def push(self, item: T) -> None:
        heappush(self._container, item)

    def pop(self) -> T:
        return heappop(self._container)
    def __repr__(self) -> str:
        return repr(self._container)
 

def astar(initial: T, goal_test: Callable[[T], bool], sucessors: Callable[[T], List[T]], heuristic: Callable[T], float) -> Optional[Node[T]]:
    # frontier corresponde aos lugares que ainda devemos visitar
    frontier: PriorityQueue[Node[T]] = PriorityQueue()
    frontier.push(Node(initial, None, 0.0, heuristic(initial)))
    # explored representa os lugres em que já estivemos
    explored: Dict[T, float] = {initial: 0.0}

    # continua enquanto houver mais lugares para explorar
    while not frontier.empty:
        current_node: Node[T] = frontier.pop()
        current_state: T = current_node.state
        # se encontrarmos o objetivo, terminamos
        if goal_test(current_state):
            return current_node
        # verifica onde podemos ir em seguida e que ainda não tenha sido explorado
        for child in sucessors(current_state):
            new_cost: float = current_node.cost + 1 # 1 supoe uma grade,
                                                    # é necessário uma função de custo para aplicações mais sofisticadas
            if child not in explored or explored[child] > new_cost:
                explored[child] = new_cost
                frontier.push(Node(child, current_node, new_cost, heuristic))
    return None # passamos por todos os lugares e não achamos o objetivo


if __name__ == "__main__":
    print(binary_contains([2, 4, 5, 8, 12, 28, 54, 99], 4))