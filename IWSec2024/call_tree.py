"""
call_tree.py: find network-related functions and their references to enumerate
                network ports
"""
# @author Tobia Bocchi
# @category Analysis
# @keybinding
# @menupath
# @toolbar

import os

FM = currentProgram.getFunctionManager()
RM = currentProgram.getReferenceManager()
TARGETS = [
    "recv",
    "bind",
    "listen",
    "connect",
    "accept",
    "prctl",
]


def construct_call_tree(tree):
    """
    tree: list of call chains
    call chain: list of functions called in sequence
    tree initially is [[target_function]]
    """
    done = True
    updated_tree = []
    for call_chain in tree:
        callee = call_chain[-1]
        callers = RM.getReferencesTo(callee.getEntryPoint())
        callers = [FM.getFunctionContaining(c.getFromAddress()) for c in callers]
        callers = [c for c in callers if c]  
        if not callers:
            updated_tree.append(call_chain)
            continue
        updated_tree.extend(
            [call_chain + [caller] for caller in callers if caller not in call_chain]
        )

        updated_tree = [list(x) for x in set(tuple(x) for x in updated_tree)]
        if updated_tree != tree:
            done = False
    return updated_tree if done else construct_call_tree(updated_tree)


if os.path.exists("/tmp/call_tree.txt"):
    os.remove("/tmp/call_tree.txt")
for func in FM.getFunctions(True):
    if func.getName().lower() not in TARGETS:
        continue

    with open("/tmp/call_tree.txt", "a") as f:
        f.write("Call tree for function: " + func.getName() + "\n")
        for chain in construct_call_tree([[func]]):
            f.write(" --> ".join([c.getName() for c in chain]) + "\n")

print("Call tree saved to /tmp/call_tree.txt")
