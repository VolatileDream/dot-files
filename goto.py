import argparse
import functools
import inspect
import itertools
import os
import re
import sys

class DictMatcher(object):

    def __init__(self):
        self.functions = []

    def __call__(self, function):
        self.register(function)

    def register(self, func):
        self.functions.append(func)

    def matches(self, **ctx):
        for func in self.functions:
            result = func(ctx)
            if not isinstance(result, list):
                result = [result]
            # Yield all non-falsey results,
            # in case we want more than the first one.
            for r in result:
                yield r


def alias(name_or_func, *aliases):
    name = [name_or_func]
    # might have been a function, use the function name
    if callable(name_or_func):
        name = [name_or_func.__name__]
    else:
        name.extend(aliases)

    def decorator(function):
        @functools.wraps(function)
        def wrapper(ctx):
            if ctx.get("alias", None) not in name:
                return []
            return function(ctx)
        return wrapper

    if callable(name_or_func):
        return decorator(name_or_func)
    else:
        return decorator


def regex(regex):
    def decorator(func):
        pattern = re.compile(regex)
        @functools.wraps(func)
        def wrapper(ctx):
            directory = ctx.get("directory", None)
            if directory is None:
                # missing directory matches nothing
                return []
            matching_groups = pattern.search(directory).groups()
            ctx = ctx.copy() # don't mutate the original
            ctx["groups"] = matching_groups
            return func(ctx)
        return wrapper
    return decorator


def unwrap(func):
    @functools.wraps(func)
    def wrapper(ctx):
        return func(**ctx)
    return wrapper

def parser():
    p = argparse.ArgumentParser()

    p.add_argument("alias")    

    return p

if __name__ == "__main__":

    args = parser().parse_args()

    code = None
    with open("/home/jex/.config/goto.pyconfig") as config_file:
        contents = "\n".join(config_file.readlines())
        code = compile(contents, "/home/jex/.config/goto.pyconfig", "exec")

    matcher = DictMatcher()
    exec_context = {
        "matcher": matcher,
        "alias" : alias,
        "regex" : regex,
        "unwrap": unwrap,
    }
    exec(code, exec_context)
    args = {
        "alias" : args.alias,
        "directory" : os.getcwd(),
    }
    atleast_one = False
    for match in matcher.matches(**args):
        atleast_one = True
        print(match)

    if not atleast_one:
        sys.exit(1)
