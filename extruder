#!/usr/bin/env python3

## from https://github.com/kyleconroy/statemachine/

from functools import wraps

class MetaMachine(type):

    def __new__(cls, name, bases, d):
        state = d.get('initial_state')

        if state == None:
            for base in bases:
                try:
                    state = base.initial_state
                    break
                except AttributeError:
                    pass

        before, after = [], []

        for name, func in d.items():
            try:
                after += [(start, end, func) for start, end in func.after]
            except AttributeError:
                pass

            try:
                before += [(start, end, func) for start, end in func.before]
            except AttributeError:
                pass

        d['_after_transitions'] = after
        d['_before_transitions'] = before
        d['_state'] = state

        return type.__new__(cls, name, bases, d)

# Python 2/3 Metaclass
# http://mikewatkins.ca/2008/11/29/python-2-and-3-metaclasses/
Machine = MetaMachine('Machine', (object, ), {
    'state': property(lambda x: x._state),
    })


def create_transition(attr, from_state, to_state):
    def wrapper(f):
        try:
            getattr(f, attr).append((from_state, to_state))
        except AttributeError:
            setattr(f, attr, [(from_state, to_state)])
        return f
    return wrapper


def after_transition(from_state, to_state):
    return create_transition('after', from_state, to_state)


def before_transition(from_state, to_state):
    return create_transition('before', from_state, to_state)


def around_transition(f):
    return f


def is_transition(start, end, current, future):
    return (start in current or start == '*') and (end in future or end == '*')

def transition_from(from_state, timing='before'):
    """Trigger the decorated function whenever transitioning
    `from` the specified state (to anything else). By default,
    fires before the state transition has taken place, so the
    :attr:`~Machine.state` will be `from_state`.
    """
    return create_transition(timing, from_state, '*')

def transition_to(to_state, timing='after'):
    """Trigger the decorated function whenever transitioning
    `to` the specified state (from anything else). By default,
    fires after the state transition has taken place, so the
    :attr:`~Machine.state` will be `to_state`.
    """
    return create_transition(timing, '*', to_state)

def event(f):
    @wraps(f)
    def wrapper(self, *args, **kwargs):
        for current, next_state in f(self, *args, **kwargs):
            if self.state in current or '*' in current:

                for start, end, method in self._before_transitions:
                    if is_transition(start, end, current, next_state):
                        method(self, *args, **kwargs)

                self._state = next_state

                for start, end, method in self._after_transitions:
                    if is_transition(start, end, current, next_state):
                        method(self, *args, **kwargs)

                return 
    return wrapper

## End of State Machine code.

class Mold(Machine):
	states = [ 'Empty', 'Var', 'Exit' ]
	initial_state = 'Empty'

	def __init__(self, in_io, out, lookup_func, escape_in=b'{{', escape_out=b'}}', log_func=lambda x: x):
		self.lookup = lookup_func
		self.escape_in = escape_in
		self.escape_out = escape_out
		self.in_io = in_io
		self.out = out
		self.content = b''
		self.perror = log_func


	@event
	def advance(self):

		escape = b''
		escape_index = 0

		self.perror( "State : " + self.state )
		self.perror( "EscIn : " + str(self.escape_in) )
		self.perror( "EscOut: " + str(self.escape_out) )

		while True:
			input = self.in_io.read(1)

			if len(input) == 0:
				if self.state == 'Var':
					# actually an error...do what?
					pass

				self.output()
				yield self.state, 'Exit'
				return

			self.perror( "input (" + str(input) + ") == self.escape_in[0]): " + str(input[0] == self.escape_in[0]) )
				
			if self.state == 'Empty' and input[0] == self.escape_in[escape_index]:
				escape += input
				escape_index += 1

				self.perror("Partial EscIn: " + str(escape) )

				if escape_index == len(self.escape_in):
					escape = b''
					escape_index = 0
					yield 'Empty', 'Var'

			elif self.state == 'Var' and input[0] == self.escape_out[escape_index]:
				escape += input
				escape_index += 1

				self.perror("Partial EscOut: " + str(escape) )

				if escape_index == len(self.escape_out):
					escape = b''
					escape_index = 0
					yield 'Var', 'Empty'

			else:
				if escape_index > 0:
					self.content += escape
					escape_index = 0
					escape = b''

				self.content += input

				if self.state == 'Empty' and len(self.content) > 1024:
					self.output()



	@transition_to('Empty')
	@transition_to('Var')
	@transition_to('Exit')
	def log(self):
		self.perror("Transition: " + self.state )


	@transition_from('Var')
	def output_var(self):
		# in case they write to self.out
		self.out.flush()

		search = str(self.content, "UTF-8")
		found = self.lookup( search, self.out )

		if found:
			self.content = bytes(found, "UTF-8")
			self.output()

		self.content = b''


	@transition_from('Empty')
	@transition_to('Exit')
	def output(self):
		self.out.write(self.content)
		self.content = b''


import os
import subprocess
import sys

def env_lookup(search, _io_out):
	# So that "clean" code can get written
	search = search.lstrip().rstrip()
	return os.environ.get( search, b'' )


def system_lookup(search, io_out ):
	retval = subprocess.call( search, stdout=io_out, shell=True )

	if retval != 0:
		raise Exception("Error building template, sub-process failure: '" + search + "'" )

	return None


import argparse

def arg_parser():
	parser = argparse.ArgumentParser()

	parser.add_argument('-s', '--system', dest='use_system', action='store_true')

	return parser


if __name__ == "__main__":

	parser = arg_parser()

	args = parser.parse_args()

	lookup_func = env_lookup
	if args.use_system:
		lookup_func = system_lookup

	sys.stdin = sys.stdin.detach()
	sys.stdout = sys.stdout.detach()

	m = Mold(sys.stdin, sys.stdout, lookup_func)

	while m.state != 'Exit':
		m.advance()

